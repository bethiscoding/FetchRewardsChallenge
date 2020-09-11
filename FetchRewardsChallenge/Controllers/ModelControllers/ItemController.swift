//
//  ItemController.swift
//  FetchRewardsChallenge
//
//  Created by Bethany Morris on 9/9/20.
//  Copyright © 2020 Bethany M. All rights reserved.
//

import Foundation

class ItemController {
    
    // MARK: - Properties
        
    private static let baseURL = URL(string: "https://fetch-hiring.s3.amazonaws.com/hiring.json")
        
    // MARK: - Methods
    
    static func fetchItems(completion: @escaping (Result<[Item], ItemError>) -> Void) {

        guard let finalURL = baseURL else { return completion(.failure(.invalidURL))}
        print("URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let topLevelObject = try JSONDecoder().decode([Item].self, from: data)
                print("Success getting items.")
                return completion(.success(topLevelObject))
            } catch {
                print("Error getting items: \(error.localizedDescription)")
                return completion(.failure(.thrownError(error)))
            }
        } .resume()
    }
    
} //End
