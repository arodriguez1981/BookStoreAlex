//
//  VolumeInfo.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation
import SwiftyJSON

class VolumeInfo: ValueObject {    
    var title: String?
    var subtitle: String?
    var authors = Array<String>()
    var publisher: String?
    var publishedDate: String?
    var desc: String?
    var industryIdentifiers: [IndustryIdentifer]?
    var pageCount: Int?
    var printType: String?
    var categories = Array<String>()
    var averageRating: Double?
    var ratingsCount: Int?
    var allowAnonLogging: Bool?
    var contentVersion: String?
    var imageLinks: ImageLinks?
    var panelizationSummary :  PanelizationSummary?
    var readingModes :  ReadingMode?
    var language: String?
    var previewLink: String?
    var infoLink: String?
    var canonicalVolumeLink: String?
    var maturityRating: String?
    
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


