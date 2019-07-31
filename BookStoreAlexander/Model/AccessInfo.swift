//
//  AccessInfo.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation
import SwiftyJSON

class AccessInfo: ValueObject {
    var country: String?
    var viewability: String?
    var embeddable: Bool?
    var quoteSharingAllowed: Bool?
    var publicDomain: Bool?
    var textToSpeechPermission: String?
    var epub: Details?
    var pdf: Details?
    var webReaderLink: String?
    var accessViewStatus: String?
    
    convenience init(_ dict: JSON){
        self.init()
        self.country = dict["country"].stringValue
        self.viewability = dict["viewability"].stringValue
        self.embeddable = dict["embeddable"].boolValue
        self.quoteSharingAllowed = dict["quoteSharingAllowed"].boolValue
        self.publicDomain = dict["publicDomain"].boolValue
        self.textToSpeechPermission = dict["textToSpeechPermission"].stringValue
        self.epub = nil
        self.pdf = nil
        self.webReaderLink = nil
        self.accessViewStatus = dict["accessViewStatus"].stringValue
    }
}

func ==(lhs: AccessInfo, rhs: AccessInfo) -> Bool {
    return lhs.country == rhs.country
        && lhs.viewability == rhs.viewability
        && lhs.embeddable == rhs.embeddable
        && lhs.publicDomain == rhs.publicDomain
        && lhs.textToSpeechPermission == rhs.textToSpeechPermission
        && lhs.epub == rhs.epub
        && lhs.pdf == rhs.pdf
        && lhs.webReaderLink == rhs.webReaderLink
        && lhs.accessViewStatus == rhs.accessViewStatus
}

