//
//  Volumes.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation
import SwiftyJSON
class Volumes {
    var kind: BooksKind = BooksKind.volumes
    var totalItems: Int?
    var items = Array<Volume>()
    
    convenience init(_ dict: JSON){
        self.init()
        self.totalItems = dict["totalItems"].intValue
        guard
            let kind : String = dict["kind"].stringValue,
            kind == BooksKind.volume.description
            else{ return }
        for (_, subJson) : (String, JSON) in dict["items"] {
            let item = Volume(subJson)
            self.items.append(item)
        }
    }
}
