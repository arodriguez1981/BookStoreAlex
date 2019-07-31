//
//  BooksKind.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//


import Foundation

public protocol Kind {
    var rawValue: String {
        get
    }
}

public enum BooksKind: String, ValueObject, Kind, CustomStringConvertible {
    case volume = "volume"
    case volumes = "volumes"
    case bookshelf = "bookshelf"
    case bookshelves = "bookshelves"
    case downloadAccessRestriction = "downloadAccessRestriction"
    
    public var description: String {
        return "books#" + rawValue
    }
    
}
