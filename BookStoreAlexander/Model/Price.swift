//
//  Price.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Price: Object {
    @objc dynamic var amount = 0.0
    @objc dynamic var currencyCode = ""
    
    convenience init(_ dict: JSON){
        self.init()
        self.amount = dict["amount"].doubleValue
        self.currencyCode = dict["currencyCode"].stringValue
    }
}

func ==(lhs: Price?, rhs: Price?) -> Bool {
    return lhs?.amount == rhs?.amount
        && lhs?.currencyCode == rhs?.currencyCode
}
