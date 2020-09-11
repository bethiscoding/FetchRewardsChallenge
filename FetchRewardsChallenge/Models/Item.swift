//
//  Item.swift
//  FetchRewardsChallenge
//
//  Created by Bethany Morris on 9/9/20.
//  Copyright © 2020 Bethany M. All rights reserved.
//

import Foundation

struct Item: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case listID = "listId"
        case name = "name"
    }
    
    let id: Int
    let listID: Int
    let name: String?
    
} //End
