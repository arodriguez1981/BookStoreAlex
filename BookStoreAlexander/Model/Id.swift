//
//  Id.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation

public struct Id<T> {
    
    public let value: String
    public init(_ value: String) {
        self.value = value
    }
}

extension Id: Equatable {}
public func ==<T>(lhs: Id<T>, rhs: Id<T>) -> Bool {
    return lhs.value == rhs.value
}

extension Id: Hashable {
    public var hashValue: Int {
        return value.hashValue
    }    
}
