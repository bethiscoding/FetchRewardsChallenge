//
//  ItemError.swift
//  FetchRewardsChallenge
//
//  Created by Bethany Morris on 9/9/20.
//  Copyright © 2020 Bethany M. All rights reserved.
//

import Foundation

enum ItemError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The server failed to reach the given URL."
        case .thrownError(let error):
            return "Oops! There was an error: \(error.localizedDescription)"
        case .noData:
            return "The server failed to provide any data."
        case .unableToDecode:
            return "There was an error trying to decode the data."
        }
    }
    
} //End
