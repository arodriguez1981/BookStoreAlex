//
//  Volume.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation
import SwiftyJSON

class Volume: Entity {
    var kind: BooksKind = BooksKind.volume
    var id: Id<Volume>?
    var etag: String?
    var selfLink: String?
    var volumeInfo: VolumeInfo?
    var userInfo: UserInfo?
    var saleInfo: SaleInfo?
    var accessInfo: AccessInfo?
    var searchInfo: SearchInfo?
    
    convenience init(_ dict: JSON){
        self.init()
        guard
            let kind : String = dict["kind"].stringValue,
            kind == BooksKind.volume.description
            else{ return }
        self.id = Id(dict["id"].stringValue)
        self.etag = dict["etag"].stringValue
        self.selfLink = dict["selfLink"].stringValue
        self.volumeInfo = VolumeInfo(dict["volumeInfo"])
        self.userInfo = UserInfo(dict["userInfo"])
        self.saleInfo = SaleInfo(dict["saleInfo"])
        self.accessInfo = AccessInfo(dict["accessInfo"])
        self.searchInfo = SearchInfo(dict["searchInfo"])
        
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
