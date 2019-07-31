//
//  PanelizationSummary.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation
import SwiftyJSON

class PanelizationSummary: ValueObject {
    var containsEpubBubbles: Bool?
    var containsImageBubbles: Bool?
   
    convenience init(_ dict: JSON){
        self.init()
        self.containsEpubBubbles = dict["containsEpubBubbles"].boolValue
        self.containsImageBubbles = dict["containsImageBubbles"].boolValue
    }
}

func ==(lhs: PanelizationSummary, rhs: PanelizationSummary) -> Bool {
    return lhs.containsEpubBubbles == rhs.containsEpubBubbles
        && lhs.containsImageBubbles == rhs.containsImageBubbles
}
