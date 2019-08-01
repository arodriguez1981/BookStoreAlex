//
//  SaleInfo.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class SaleInfo: Object {
     @objc dynamic var country: String?
     @objc dynamic var saleability: String?
     @objc dynamic var isEbook = false
     @objc dynamic var listPrice: Price?
     @objc dynamic var retailPrice: Price?
     @objc dynamic var buyLink: String?
    
    convenience init(_ dict: JSON){
        self.init()
        self.country = dict["country"].stringValue
        self.saleability = dict["saleability"].stringValue
        self.isEbook = dict["isEbook"].boolValue
        self.listPrice = Price(dict["listPrice"])
        self.retailPrice = Price(dict["retailPrice"])
        self.buyLink = dict["buyLink"].stringValue
    }
}

func ==(lhs: SaleInfo, rhs: SaleInfo) -> Bool {
    return lhs.country == rhs.country
        && lhs.saleability == rhs.saleability
        && lhs.isEbook == rhs.isEbook
        && lhs.listPrice == rhs.listPrice
        && lhs.retailPrice == rhs.retailPrice
        && lhs.buyLink == rhs.buyLink
}
    
