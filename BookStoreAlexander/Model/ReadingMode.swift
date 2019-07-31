//
//  ReadingModes.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation
import SwiftyJSON

class ReadingMode: ValueObject {
    var image: Bool?
    var text: Bool?
    
    convenience init(_ dict: JSON){
        self.init()
        self.image = dict["image"].boolValue
        self.text = dict["text"].boolValue
    }
}

func ==(lhs: ReadingMode, rhs: ReadingMode) -> Bool {
    return lhs.image == rhs.image
        && lhs.text == rhs.text
}
