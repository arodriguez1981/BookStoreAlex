//
//  UserInfo.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class UserInfo: Object {
     @objc dynamic var isPurchased = false
     @objc dynamic var isPreorderd = false
    
    convenience init(_ dict: JSON){
        self.init()
        self.isPurchased = dict["isPurchased"].boolValue
        self.isPreorderd = dict["isPreorderd"].boolValue
    }
}

func ==(lhs: UserInfo, rhs: UserInfo) -> Bool {
    return lhs.isPurchased == rhs.isPurchased
        && lhs.isPreorderd == rhs.isPreorderd
}
