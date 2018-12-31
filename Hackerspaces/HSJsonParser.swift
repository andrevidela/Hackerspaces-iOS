//
//  HackerspaceDataModel.swift
//  Hackerspaces
//
//  Created by zephyz on 29/08/15.
//  Copyright (c) 2015 Fixme. All rights reserved.
//

import Foundation
import Swiftz
import MapKit
import Result

enum ParsingErrors: Error {
    case gpsLocationMissing(file: String)
    case stateFieldMissing(file: String)
    case spaceNameMissing(file: String)
    case jsonParsingError(file: String, message: String)
    case fileNotUTF8Encoded
}

func parseHackerspaceDataModel(json: HSData, name apiName: String, url: String) -> Result<ParsedHackerspaceData, ParsingErrors>  {
    guard let file = String(data: json, encoding: .utf8) else {
        return .failure(.fileNotUTF8Encoded)
    }
    let parsed: HackerspaceData
    do {
        parsed = try JSONDecoder().decode(HackerspaceData.self, from: json)
    } catch let error {
        return .failure(.jsonParsingError(file: file, message: "\(error)"))
    }

    guard case .Left(let location) = parsed.location else {
        return .failure(ParsingErrors.gpsLocationMissing(file: file))
    }
    guard let space = parsed.space else {
        return .failure(ParsingErrors.spaceNameMissing(file: file))
    }
    guard let state = parsed.state else {
        return .failure(ParsingErrors.stateFieldMissing(file: file))
    }
    return .success(ParsedHackerspaceData(apiVersion: parsed.api,
                                          apiEndpoint: url,
                                          apiName: apiName,
                                          name: space,
                                          logoURL: parsed.logo,
                                          websiteURL: parsed.url,
                                          state: state,
                                          location: location,
                                          contact: parsed.contact))
}

struct ParsedHackerspaceData: Codable {
    let apiVersion: String
    let apiEndpoint: String
    let apiName: String
    let name: String
    let logoURL: String
    let websiteURL: String
    let state: StateData
    let location: LocationData
    let contact: ContactData
    let cam: [String] = []
    let spaceFed: SpaceFedData? = nil
    let events: [EventData] = []
    let projects: String? = nil
    var apiInfo: (name: String, url: String) {
        return (name: apiName, url: apiEndpoint)
    }

    func toSpaceLocation() -> SpaceLocation {
        return SpaceLocation(hackerspace: self)
    }
}

struct SpaceFedData: Codable {
    let spacenet: Bool
    let spacesaml: Bool
    let spacephone: Bool
}

struct LocationData: Codable {
    let address: String?
    let lat: Float
    let lon: Float
}

struct MissingGPSData: Codable {
    let address: String?
}

struct StateData: Codable {
    let open: Bool
    let lastchange: Float?
    let trigger_person: String?
    let message: String?
    let icon: IconData?
}

struct IconData: Codable {
    let open: String
    let closed: String
}

struct EventData: Codable {
    let name: String
    let type: String
    let timestamp: Float
    let extra: String?
}

struct MemberData: Codable {
    let name: String?
    let irc_nick: String?
    let phone: String?
    let email: String?
    let twitter: String?
    init(name: String? = nil,
         irc_nick: String? = nil,
         phone: String? = nil,
         email: String? = nil,
         twitter: String? = nil) {
        self.name = name
        self.irc_nick = irc_nick
        self.phone = phone
        self.email = email
        self.twitter = twitter
    }
}

struct ContactData: Codable {
    let phone: String?
    let sip: String?
    let keyMasters: [MemberData]?
    let irc: String?
    let twitter: String?
    let facebook: String?
    let identica: String?
    let foursquare: String?
    let email: String?
    let ml: String?
    let jabber: String?
    let issue_mail: String?
    init(phone: String? = nil,
         sip: String? = nil,
         keyMasters: [MemberData] = [],
         ircURL: String? = nil,
         twitterHandle: String? = nil,
         facebook: String? = nil,
         identica: String? = nil,
         foursquareID: String? = nil,
         email: String? = nil,
         mailingList: String? = nil,
         jabber: String? = nil,
         issue_mail: String? = nil
        ) {
        self.phone = phone
        self.sip = sip
        self.keyMasters = keyMasters
        self.irc = ircURL
        self.twitter = twitterHandle
        self.facebook = facebook
        self.identica = identica
        self.foursquare = foursquareID
        self.email = email
        self.ml = mailingList
        self.jabber = jabber
        self.issue_mail = issue_mail
    }
}

struct HackerspaceData: Codable {
    let api: String
    let space: String?
    let logo: String
    let url: String
    let location: Either<LocationData, MissingGPSData>
    let spacefed: SpaceFedData?
    let cam: [String]?
    let state: StateData?
    let events: [EventData]?
    let contact: ContactData
}
