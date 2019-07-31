//
//  ImageLinks.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation
import SwiftyJSON
class ImageLinks: ValueObject {
    var smallThumbnail: String?
    var thumbnail: String?
    
    convenience init(_ dict: JSON){
        self.init()
        self.smallThumbnail = dict["smallThumbnail"].stringValue
        self.thumbnail = dict["thumbnail"].stringValue
    }
}

func ==(lhs: ImageLinks, rhs: ImageLinks) -> Bool {
    return lhs.smallThumbnail == rhs.smallThumbnail
        && lhs.thumbnail == rhs.thumbnail
}
