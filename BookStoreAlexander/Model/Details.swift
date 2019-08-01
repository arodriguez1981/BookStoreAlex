//
//  Details.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Details: Object {
   @objc dynamic var  isAvailable = false
    @objc dynamic var  acsTokenLink: String?
    
    convenience init(_ dict: JSON){
        self.init()
        self.isAvailable = dict["isAvailable"].boolValue
        self.acsTokenLink = dict["acsTokenLink"].stringValue
    }
}

func ==(lhs: Details, rhs: Details) -> Bool {
    return lhs.isAvailable == rhs.isAvailable
        && lhs.acsTokenLink == rhs.acsTokenLink
}
