//
//  Item.swift
//  FetchRewardsChallenge
//
//  Created by Bethany Morris on 9/9/20.
//  Copyright © 2020 Bethany M. All rights reserved.
//

import Foundation

//struct TopLevelObject: Codable {
//    var JSON: [Item]
//}

struct Item: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case ID = "id"
        case listID = "listId"
        case name = "name"
    }
    
    let ID: Int
    let listID: Int
    let name: String?
    
}
