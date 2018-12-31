//
//  HackerspacesTests.swift
//  HackerspacesTests
//
//  Created by zephyz on 05/08/15.
//  Copyright (c) 2015 Fixme. All rights reserved.
//

import UIKit
import XCTest

class HackerspacesTests: XCTestCase {

    func testJSONParsing() {
        // This is an example of a functional test case.
        let json = "{\"state\": {\"ext_duration\": 0, \"lastchange\": 1501290658.0, \"open\": false, \"message\": \"The space is closed.\", \"icon\": {\"open\": \"https://fixme.ch/sites/default/files/logo-open.png\", \"closed\": \"https://fixme.ch/sites/default/files/logo-closed.png\"}}, \"api\": \"0.13\", \"location\": {\"lat\": 46.532372, \"lon\": 6.591292, \"address\": \"Chemin du Closel 5, 1020 Renens, Switzerland\"}, \"space\": \"FIXME\", \"url\": \"https://fixme.ch\", \"logo\": \"https://fixme.ch/sites/default/files/Logo5_v3-mini.png\", \"feeds\": {\"blog\": {\"url\": \"https://fixme.ch/rss.xml\", \"type\": \"rss\"}, \"wiki\": {\"url\": \"https://fixme.ch/w/index.php?title=Special:RecentChanges&feed=atom\", \"type\": \"rss\"}, \"calendar\": {\"url\": \"https://www.google.com/calendar/ical/sruulkb8vh28dim9bcth8emdm4%40group.calendar.google.com/public/basic.ics\", \"type\": \"ical\"}}, \"issue_report_channels\": [\"email\", \"twitter\"], \"sensors\": {\"people_now_present\": [{\"unit\": \"device(s)\", \"value\": 0, \"description\": \"Number of devices in the DHCP range\"}], \"total_member_count\": [{\"unit\": \"premium members\", \"value\": 46}, {\"unit\": \"standard members\", \"value\": 65}, {\"unit\": \"total members\", \"value\": 111}]}, \"contact\": {\"wiki\": \"https://wiki.fixme.ch\", \"phone\": \"+41216220734\", \"facebook\": \"https://www.facebook.com/fixmehackerspace\", \"chat\": \"https://chat.fixme.ch\", \"ml\": \"hackerspace-lausanne@lists.saitis.net\", \"twitter\": \"@_fixme\", \"irc\": \"irc://freenode/#fixme\", \"email\": \"info@fixme.ch\", \"keymaster\": [\"+41797440880\"]}}"
        guard let j = json.data(using: .utf8) else { XCTFail(); return }
        let parsed = parseHackerspaceDataModel(json: j, name: "fixme", url: "").value
        XCTAssertNotNil(parsed)
        let data = parsed!
        XCTAssertEqual(data.name, "FIXME")
        XCTAssertEqual(data.state.open, false)
    }

    func testJSONParsin2() {
        let json = "{\"state\": {\"ext_duration\": 2, \"lastchange\": 1501975764.0, \"open\": true, \"message\": \"The space is open.\", \"icon\": {\"open\": \"https://fixme.ch/sites/default/files/logo-open.png\", \"closed\": \"https://fixme.ch/sites/default/files/logo-closed.png\"}}, \"api\": \"0.13\", \"location\": {\"lat\": 46.532372, \"lon\": 6.591292, \"address\": \"Chemin du Closel 5, 1020 Renens, Switzerland\"}, \"space\": \"FIXME\", \"url\": \"https://fixme.ch\", \"logo\": \"https://fixme.ch/sites/default/files/Logo5_v3-mini.png\", \"feeds\": {\"blog\": {\"url\": \"https://fixme.ch/rss.xml\", \"type\": \"rss\"}, \"wiki\": {\"url\": \"https://fixme.ch/w/index.php?title=Special:RecentChanges&feed=atom\", \"type\": \"rss\"}, \"calendar\": {\"url\": \"https://www.google.com/calendar/ical/sruulkb8vh28dim9bcth8emdm4%40group.calendar.google.com/public/basic.ics\", \"type\": \"ical\"}}, \"issue_report_channels\": [\"email\", \"twitter\"], \"sensors\": {\"people_now_present\": [{\"unit\": \"device(s)\", \"value\": 9, \"description\": \"Number of devices in the DHCP range\"}], \"total_member_count\": [{\"unit\": \"premium members\", \"value\": 46}, {\"unit\": \"standard members\", \"value\": 65}, {\"unit\": \"total members\", \"value\": 111}]}, \"contact\": {\"wiki\": \"https://wiki.fixme.ch\", \"phone\": \"+41216220734\", \"facebook\": \"https://www.facebook.com/fixmehackerspace\", \"chat\": \"https://chat.fixme.ch\", \"ml\": \"hackerspace-lausanne@lists.saitis.net\", \"twitter\": \"@_fixme\", \"irc\": \"irc://freenode/#fixme\", \"email\": \"info@fixme.ch\", \"keymaster\": [\"+41797440880\"]}}"


        guard let j = json.data(using: .utf8) else { XCTFail(); return }

        let parsed = parseHackerspaceDataModel(json: j, name: "fixme", url: "").value
        XCTAssertNotNil(parsed)
        let data = parsed!
        XCTAssertEqual(data.name, "FIXME")
        XCTAssertEqual(data.state.open, true)
        XCTAssertEqual(data.state.message, "The space is open.")
    }

    func testJSONParsing3() {
        let json = "{\"state\": {\"ext_duration\": 0, \"lastchange\": 1501986610.0, \"open\": false, \"message\": \"The space is closed.\", \"icon\": {\"open\": \"https://fixme.ch/sites/default/files/logo-open.png\", \"closed\": \"https://fixme.ch/sites/default/files/logo-closed.png\"}}, \"api\": \"0.13\", \"location\": {\"lat\": 46.532372, \"lon\": 6.591292, \"address\": \"Chemin du Closel 5, 1020 Renens, Switzerland\"}, \"space\": \"FIXME\", \"url\": \"https://fixme.ch\", \"logo\": \"https://fixme.ch/sites/default/files/Logo5_v3-mini.png\", \"feeds\": {\"blog\": {\"url\": \"https://fixme.ch/rss.xml\", \"type\": \"rss\"}, \"wiki\": {\"url\": \"https://fixme.ch/w/index.php?title=Special:RecentChanges&feed=atom\", \"type\": \"rss\"}, \"calendar\": {\"url\": \"https://www.google.com/calendar/ical/sruulkb8vh28dim9bcth8emdm4%40group.calendar.google.com/public/basic.ics\", \"type\": \"ical\"}}, \"issue_report_channels\": [\"email\", \"twitter\"], \"sensors\": {\"people_now_present\": [{\"unit\": \"device(s)\", \"value\": 7, \"description\": \"Number of devices in the DHCP range\"}], \"total_member_count\": [{\"unit\": \"premium members\", \"value\": 46}, {\"unit\": \"standard members\", \"value\": 65}, {\"unit\": \"total members\", \"value\": 111}]}, \"contact\": {\"wiki\": \"https://wiki.fixme.ch\", \"phone\": \"+41216220734\", \"facebook\": \"https://www.facebook.com/fixmehackerspace\", \"chat\": \"https://chat.fixme.ch\", \"ml\": \"hackerspace-lausanne@lists.saitis.net\", \"twitter\": \"@_fixme\", \"irc\": \"irc://freenode/#fixme\", \"email\": \"info@fixme.ch\", \"keymaster\": [\"+41797440880\"]}}"
        guard let j = json.data(using: .utf8) else { XCTFail(); return }

        let parsed = parseHackerspaceDataModel(json: j, name: "fixme", url: "").value
        XCTAssertNotNil(parsed)
        let data = parsed!
        XCTAssertEqual(data.name, "FIXME")
        XCTAssertEqual(data.state.open, false)
        XCTAssertEqual(data.state.message, "The space is closed.")
    }
    func testJSONParsing4() {
        let json = """
            {
              "api": "0.13",
              "space": "Arch Reactor",
              "url": "https://archreactor.org",
              "logo": "https://archreactor.org/sites/default/files/bwarniceshadow.png",
              "location": {
                "address": "2215 Scott Avenue Saint Louis, MO 63103"
              },
              "contact": {
                "irc": "ircs://chat.freenode.net/archreactor",
                "twitter": "ArchReactorSTL",
                "email": "admin@archreactor.org",
                "ml": "arch-reactor@googlegroups.com"
              },
              "feeds": {
                "blog": {
                  "url": "https://archreactor.org/blog.rss",
                  "type": "rss"
                },
                "calendar": {
                  "url": "https://calendar.google.com/calendar/ical/archreactor.org_35u4kfplq0l9n5291ckr3uei9k%40group.calendar.google.com/public/basic.ics",
                  "type": "ical"
                }
              }
            }
            """
        guard let j = json.data(using: .utf8) else { XCTFail(); return }

        if case .failure(.gpsLocationMissing) = parseHackerspaceDataModel(json: j, name: "Arch Reactor", url: "") {
            XCTAssert(true)
        } else {
            XCTFail("expected parsing to fail")
        }
    }

    func testJSONParsing5() {
        let json = """
                {
                "api":"0.13",
                "space":"Nova Labs",
                "logo":"http:\\/\\/nova-labs.org\\/images\\/nova-labs_icon_160x160.png",
                "url":"http:\\/\\/www.nova-labs.org",
                "location":{
                    "address":"1916 Isaac Newton Square W, Reston, VA 20190 USA",
                    "lon":-77.338769,
                    "lat":38.95455
                },
                "contact":{
                    "email":"info@nova-labs.org",
                    "phone":"+1 (571) 313-8908",
                    "twitter":"@novalabs",
                    "irc":"irc:\\/\\/irc.freenode.net\\/#novalabs",
                    "facebook":"https:\\/\\/www.facebook.com\\/NovaLabsVA",
                    "google":{
                        "plus":"https:\\/\\/plus.google.com\\/u\\/0\\/101146091795041044262\\/about"
                    },
                    "ext_linkedin":"http:\\/\\/www.linkedin.com\\/groups\\/Nova-Labs-4312248",
                    "ext_meetup":"http:\\/\\/www.meetup.com\\/Nova-Makers\\/",
                    "ext_slack":"https:\\/\\/nova-labs-org.slack.com\\/"
                },
                "issue_report_channels":[
                "email"
                ],
                "state":{
                    "open":false,
                    "lastchange":1545603704,
                    "message":"Closed",
                    "icon":{
                        "open":"http:\\/\\/nova-labs.org\\/api\\/nova-labs-open_icon_800x800.png",
                        "closed":"http:\\/\\/nova-labs.org\\/api\\/nova-labs-closed_icon_800x800.png"
                    }
                },
                "cache":{
                    "schedule":"m.05"
                },
                "open":false,
                "status":"closed",
                "icon":{
                    "open":"http:\\/\\/nova-labs.org\\/api\\/nova-labs-open_icon_800x800.png",
                    "closed":"http:\\/\\/nova-labs.org\\/api\\/nova-labs-closed_icon_800x800.png"
                },
                "feeds":{
                    "flickr":{
                        "type":"atom",
                        "url":"https:\\/\\/www.flickr.com\\/services\\/feeds\\/photos_public.gne?id=78255633@N07&lang=en-us&format=atom"
                    },
                    "blog":{
                        "type":"rss",
                        "url":"https:\\/\\/www.nova-labs.org\\/blog\\/feed\\/"
                    },
                    "calendar":{
                        "type":"ical",
                        "url":"http:\\/\\/api.meetup.com\\/Nova-Makers\\/upcoming.ical"
                    }
                }
            }
            """
        guard let j = json.data(using: .utf8) else { XCTFail(); return }

        let parsed = parseHackerspaceDataModel(json: j, name: "Nova Labs", url: "")
        XCTAssertNotNil(parsed.value)

    }
}
