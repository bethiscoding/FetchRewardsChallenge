//
//  ListController.swift
//  FetchRewardsChallenge
//
//  Created by Bethany Morris on 9/9/20.
//  Copyright © 2020 Bethany M. All rights reserved.
//

import Foundation

class ListController {
    
    // MARK: - Singleton
    
    static let shared = ListController()
    
    // MARK: - Source of Truth
    
    var lists = [List]()
    
    // MARK: - CRUD Methods
    
    func create(id: Int) {
        let list = List(id: id)
        lists.append(list)
    }
    
    func addItem(item: Item) {
        for list in lists {
            if list.id == item.listID {
                list.items.append(item)
            }
        }
    }
    
} //End
