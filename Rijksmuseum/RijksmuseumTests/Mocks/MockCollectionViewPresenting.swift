//
//  MockCollectionViewPresenting.swift
//  RijksmuseumTests
//
//  Created by Troian on 01.06.2023.
//

import Foundation

class MockCollectionViewPresenting: CollectionViewPresenting {
    var isStarted = false
    var isLoading = false
    var isUpdated = false
    var isNotFound = false
    var updatedHandler: (() -> Void)?
    var notFoundHandler: (() -> Void)?
    
    func started() {
        isStarted = true
    }
    
    func loading() {
        isLoading = true
    }
    
    func updated() {
        isUpdated = true
        updatedHandler?()
    }
    
    func notFound() {
        isNotFound = true
        notFoundHandler?()
    }
}

