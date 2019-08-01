//
//  VolumeInfo.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class VolumeInfo: Object {
     @objc dynamic var title: String?
     @objc dynamic var subtitle: String?
     var authors = List<String>()
     @objc dynamic var publisher: String?
     @objc dynamic var publishedDate: String?
     @objc dynamic var desc: String?
     var industryIdentifiers: [IndustryIdentifer]?
     @objc dynamic var pageCount = 0
     @objc dynamic var printType: String?
     var categories = List<String>()
     @objc dynamic var averageRating = 0.0
     @objc dynamic var ratingsCount = 0
     @objc dynamic var allowAnonLogging = false
     @objc dynamic var contentVersion: String?
     @objc dynamic var imageLinks: ImageLinks?
     @objc dynamic var panelizationSummary :  PanelizationSummary?
     @objc dynamic var readingModes :  ReadingMode?
     @objc dynamic var language: String?
     @objc dynamic var previewLink: String?
     @objc dynamic var infoLink: String?
     @objc dynamic var canonicalVolumeLink: String?
     @objc dynamic var maturityRating: String?
    
    convenience init(_ dict: JSON){
        self.init()
        self.title = dict["title"].stringValue
        self.subtitle = dict["subtitle"].stringValue
        self.publisher = dict["publisher"].stringValue
        self.publishedDate = dict["publishedDate"].stringValue
        self.desc = dict["description"].stringValue
        self.pageCount = dict["pageCount"].intValue
        self.allowAnonLogging = dict["allowAnonLogging"].boolValue
        self.printType = dict["printType"].stringValue
        self.averageRating = dict["avarageRating"].doubleValue
        self.ratingsCount = dict["ratingsCount"].intValue
        self.contentVersion = dict["contentVersion"].stringValue
        self.maturityRating = dict["maturityRating"].stringValue
        self.language = dict["language"].stringValue
        self.previewLink = dict["previewLink"].stringValue
        self.infoLink = dict["infoLink"].stringValue
        self.canonicalVolumeLink = dict["canonicalVolumeLink"].stringValue
        self.panelizationSummary = PanelizationSummary(dict["panelizationSummary"])
        self.readingModes = ReadingMode(dict["readingModes"])
        self.imageLinks =  ImageLinks(dict["imageLinks"])
        
        for (_, subJson) : (String, JSON) in dict["industryIdentifiers"] {
            let ident = IndustryIdentifer(subJson)
            self.industryIdentifiers?.append(ident)
        }

        for (_, subJson) : (String, JSON) in dict["categories"] {
            self.categories.append(subJson.stringValue)
        }
        
        for (_, subJson) : (String, JSON) in dict["authors"] {
            self.authors.append(subJson.stringValue)
        }
    }
}

func ==(lhs: VolumeInfo, rhs: VolumeInfo) -> Bool {
    return lhs.title == rhs.title
        && lhs.subtitle == rhs.subtitle
        && lhs.authors == rhs.authors
        && lhs.publisher == rhs.publisher
        && lhs.publishedDate == rhs.publishedDate
        && lhs.desc == rhs.desc
        && lhs.industryIdentifiers == rhs.industryIdentifiers
        && lhs.pageCount == rhs.pageCount
        && lhs.printType == rhs.printType
        && lhs.categories == rhs.categories
        && lhs.averageRating == rhs.averageRating
        && lhs.ratingsCount == rhs.ratingsCount
        && lhs.contentVersion == rhs.contentVersion
        && lhs.imageLinks == rhs.imageLinks
        && lhs.language == rhs.language
        && lhs.previewLink == rhs.previewLink
        && lhs.infoLink == rhs.infoLink
        && lhs.canonicalVolumeLink == rhs.canonicalVolumeLink
}


