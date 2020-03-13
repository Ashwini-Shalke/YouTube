//
//  Video.swift
//  Youtube
//
//  Created by Ashwini shalke on 06/03/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class Video : Decodable{
    var thumbnailImage: String?
    var title:String?
    var numberOfViews: Int?
    var uploadDate: Date?
    var channel: Channel?
    
    enum CodingKeys : String, CodingKey {
        case title
        case thumbnailImage = "thumbnail_image_name"
        case numberOfViews = "number_of_views"
        case uploadDate
        case channel
    }
    
}

class Channel : Decodable {
    var name : String?
    var profileImageName : String?
    enum CodingKeys : String, CodingKey {
        case name
        case profileImageName = "profile_image_name"
    }
}


