//
//  DataModel.swift
//  IncuLink
//
//  Created by Ananya Kumar on 05/06/24.
//

import Foundation
import UIKit

struct User: Codable{
    let userName : String
    let email : String
    var phoneNo : Int
    
}

// Data model of home tab
struct SuccessStories : Codable { // for home page
//    var uid : UUID
    var name : String
    var incubationName : String
    var foundedYear : Int
    var thumbnailURL : String
    
    
    enum CodingKeys : String , CodingKey{
//        case uid
        case name
        case incubationName
        case foundedYear
        case thumbnailURL = "thumbnail_URL"
    }
}


struct SuccessStoriesDetails {  // details of Success Stories on home page
    let name: String
    let founders: String
    let incubationUsed: String
    let schemes: String
    let domain: String
    let publicRating: Double
    let thumbnailImage: String?
}

struct SchemeImage{ // for home page scheme images
    var image : String?
}

struct SchemesDetails {  // for schemes details
    var title : String
    var shortDescription : String
    var startupSupported : String
    var websiteLink : String
    var thumbnailImage : String?
}


struct IncubationCentreList{ // for home page
    //    var uid : UUID
    var name : String
    var incubatedStartup: Int
    var thumbnailURL : String
    var latitude : Double
    var longitude : Double
}



struct IncubationCentreDetails {
    // Details of incubation centre on home page
    let name: String
    let established: Int
    let numberOfStartupsIncubated: Int
    let recognizedAndFundedBy: String
    let location: String
    let thumbnailImage: String?
    let latitude: Double
    let longitude: Double
}
struct Section1Data {
    var eventImage: String
    var eventName: String
}


// Data model for community tab

struct Section2Data {
    var channelNames: String
}
struct ChannelsDetail {
    var channelLogoImage: String
    var channelName: String
    var isJoined: Bool = false
}

struct EventsDetail {
    var images: String
    var titleNames: String
    var dateOfEvents: String
    var timeOfEvents: String
    var venueOfEvents: String
    var descriptionOfEvents: String
    var website: String
}


// Data model of collab zone tab

struct CollaborationOpportunity {
    var companyName: String
    var title: String
    var location: String
    var description: String
    var needsExperience: Bool
    var skill1: String
    var skill2: String
    var user_id : String
    var logoDownloadUrl : String
    var bookMark : Bool
    
}


