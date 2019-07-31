//
//  Details.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation
public struct Details: ValueObject {
    public let isAvailable: Bool
//    public let downloadLink: URL
    public let acsTokenLink: URL
}

public func ==(lhs: Details, rhs: Details) -> Bool {
    return lhs.isAvailable == rhs.isAvailable
//        && lhs.downloadLink == rhs.downloadLink
        && lhs.acsTokenLink == rhs.acsTokenLink
}
