//
//  MockCollectionProviding.swift
//  RijksmuseumTests
//
//  Created by Troian on 01.06.2023.
//

import Foundation

class MockCollectionProviding: CollectionProviding {
    var collection: [ArtObject] = []
    var error: Error?
    func getCollection() async throws -> [ArtObject] {
        if let error = self.error {
            throw error
        }
        return collection
    }
    
    var offset: Int = 1
    
    var limit: Int = 1
    
}
