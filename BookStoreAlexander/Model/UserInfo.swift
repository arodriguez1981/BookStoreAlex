//
//  UserInfo.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserInfo: ValueObject {
    var isPurchased: Bool?
    var isPreorderd: Bool?
    var updated: Date?
    
    convenience init(_ dict: JSON){
        self.init()
        self.isPurchased = dict["isPurchased"].boolValue
        self.isPreorderd = dict["isPreorderd"].boolValue
        self.updated = dict["update"] as? Date
    }
}

func ==(lhs: UserInfo, rhs: UserInfo) -> Bool {
    return lhs.isPurchased == rhs.isPurchased
        && lhs.isPreorderd == rhs.isPreorderd
        && lhs.updated == rhs.updated
}
