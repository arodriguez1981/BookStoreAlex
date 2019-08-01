//
//  SearchInfo.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class SearchInfo: Object {
    @objc dynamic var textSnippet: String?
    
    convenience init(_ dict: JSON){
        self.init()
        self.textSnippet = dict["textSnippet"].stringValue
    }
}

func ==(lhs: SearchInfo, rhs: SearchInfo) -> Bool {
    return lhs.textSnippet == rhs.textSnippet
}
