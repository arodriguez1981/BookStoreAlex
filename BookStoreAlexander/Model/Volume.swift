//
//  Volume.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

var realm: Realm!

class Volume: Object{
    @objc dynamic var kind: String?
    @objc dynamic var id: String?
    @objc dynamic var fav = 0
    @objc dynamic var etag: String?
    @objc dynamic var selfLink: String?
    @objc dynamic var volumeInfo: VolumeInfo?
    @objc dynamic var userInfo: UserInfo?
    @objc dynamic var saleInfo: SaleInfo?
    @objc dynamic var accessInfo: AccessInfo?
    @objc dynamic var searchInfo: SearchInfo?
    
    convenience init(_ dict: JSON){
        self.init()
        self.kind = dict["kind"].stringValue
        self.id = dict["id"].stringValue
        self.etag = dict["etag"].stringValue
        self.selfLink = dict["selfLink"].stringValue
        self.volumeInfo = VolumeInfo(dict["volumeInfo"])
        self.userInfo = UserInfo(dict["userInfo"])
        self.saleInfo = SaleInfo(dict["saleInfo"])
        self.accessInfo = AccessInfo(dict["accessInfo"])
        self.searchInfo = SearchInfo(dict["searchInfo"])
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

func ==(lhs: Volume, rhs: Volume) -> Bool {
    return lhs.kind == rhs.kind
        && lhs.id == rhs.id
        && lhs.etag == rhs.etag
        && lhs.selfLink == rhs.selfLink
        && lhs.volumeInfo == rhs.volumeInfo
        && lhs.userInfo == rhs.userInfo
        && lhs.saleInfo == rhs.saleInfo
        && lhs.accessInfo == rhs.accessInfo
        && lhs.searchInfo == rhs.searchInfo
}


