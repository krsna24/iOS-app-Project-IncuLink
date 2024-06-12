//
//  CommunityDataModel.swift
//  IncuLink
//
//  Created by Ankit Rajput on 29/05/24.
//

import Foundation


class CommunityDataModel {
    static var section1: [Section1Data] = [
        Section1Data(eventImage: "Event1", eventName: "Crowdfeuz Presents GrowthXChange"),
        Section1Data(eventImage: "Event2", eventName: "The MSME Times Excellence Awards & Business Conference 2024 : 2nd Edition"),
        Section1Data(eventImage: "Event3", eventName: "Delhi Startup Networking Event(Invite Only) by AY Ventures"),
        Section1Data(eventImage: "Event4", eventName: "Delhi Business networking Meetup - start-ups , funding, networking"),
        Section1Data(eventImage: "Event5", eventName: "India Startup Summit (4th Edition) & Startup Achievers' Awards 2024"),
        Section1Data(eventImage: "Event6", eventName: "Entrepreneur Meet Ups"),
        Section1Data(eventImage: "Event7", eventName: "India - Dubai Business Summit (Delhi) : Learning, Networking, Investing/Funding"),
        Section1Data(eventImage: "Event8", eventName: "Women Listed Bazaar: Monsoon Edition"),
        Section1Data(eventImage: "Event9", eventName: "I-Venture Immersive (ivi) Inaugural Info Session in Delhi")
    ]
    
    static var section2: [Section2Data] = [
        Section2Data(channelNames: "FinTech"),
        Section2Data(channelNames: "Technology"),
        Section2Data(channelNames: "SaaS"),
        Section2Data(channelNames: "HealthTech"),
        Section2Data(channelNames: "IOT-Internet Of Things"),
        Section2Data(channelNames: "Cyber Security"),
        Section2Data(channelNames: "AgriTech"),
        Section2Data(channelNames: "BioTech")
    ]
    
    static var sectionHeaders: [String] = ["Events", "Channels"]
}
