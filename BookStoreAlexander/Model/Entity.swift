//
//  Entity.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation

public protocol Entity {
    associatedtype ID: Equatable
    var id: ID { get }
}

extension Entity {
    public func hasSameIdentity(_ other: Self) -> Bool {
        return id == other.id
    }
}
