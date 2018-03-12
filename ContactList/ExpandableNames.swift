//
//  ExpandableNames.swift
//  ContactList
//
//  Created by Appinventiv mac on 24/02/18.
//  Copyright © 2018 Appinventiv mac. All rights reserved.
//

import Foundation
struct ExpandableNames {
    var isExpanded : Bool
    var  names : [Contact]
    
}
struct Contact {
    
     let name : String
    var hasFavourited : Bool
}
