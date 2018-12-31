//
//  SecondViewController.swift
//  Hackerspaces
//
//  Created by zephyz on 05/08/15.
//  Copyright (c) 2015 Fixme. All rights reserved.
//

import UIKit
import Swiftz
import MapKit
import BrightFutures

class MapViewController: UIViewController, CLLocationManagerDelegate {


    @IBOutlet weak var centerButtonOutlet: UIButton! {
        didSet {
            centerButtonOutlet.setImage(centerButtonOutlet.currentImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
            centerButtonOutlet.tintColor = Theme.conditionalTintColor
        }
    }

    @IBAction func centerMap(_ sender: UIButton) {
        locationManager.location.forEach(centerMapOnLocation)

    }

    
    @IBOutlet weak var map: MKMapView! {
        didSet {
            map.delegate = self as MKMapViewDelegate
        }
    }

    let locationManager = CLLocationManager()
    var refreshButton: UIBarButtonItem!
    var loadingIndicator: UIBarButtonItem!

    @IBAction func resetMap(_ sender: UILongPressGestureRecognizer) {
        if let location = locationManager.location {
            centerMapOnLocation(location)
        }
    }

    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            map.showsUserLocation = true
            map.userTrackingMode = MKUserTrackingMode.none
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func centerMapOnLocation(_ location: CLLocation) {
        let regionRadius: CLLocationDistance = 5000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
    }

    @objc func refresh(sender: UIBarButtonItem) {
        self.navigationItem.rightBarButtonItem = loadingIndicator
        self.map.removeAnnotations(map.annotations)

        SpaceAPI.loadHackerspaceList(fromCache: true).onSuccess { hsDict in
            let list = hsDict.map({ (name, url) in
                SpaceAPI.getParsedHackerspace(url: url, name: name, fromCache: false)
                    .map(SpaceLocation.init)
                    .map(self.map.addAnnotation)
            })
            list.sequence().onComplete { _ in
                self.navigationItem.rightBarButtonItem = self.refreshButton
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(refresh))
        self.navigationItem.rightBarButtonItem = refreshButton
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        indicator.startAnimating()
        loadingIndicator = UIBarButtonItem(customView: indicator)
        refresh(sender: refreshButton)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
}

