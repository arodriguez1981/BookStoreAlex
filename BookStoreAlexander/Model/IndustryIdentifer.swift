//
//  IndustryIdentifer.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class IndustryIdentifer: Object {
     @objc dynamic var type: String?
     @objc dynamic var identifier: String?
    
    convenience init(_ dict: JSON){
        self.init()
        self.type = dict["type"].stringValue
        self.identifier = dict["identifier"].stringValue    
    }
}

func ==(lhs: IndustryIdentifer, rhs: IndustryIdentifer) -> Bool {
    return lhs.identifier == rhs.identifier
        && lhs.type == rhs.type
}
