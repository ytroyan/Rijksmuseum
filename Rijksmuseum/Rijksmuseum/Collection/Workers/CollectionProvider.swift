//
//  CollectionProvider.swift
//  Rijksmuseum
//
//  Created by Troian on 31.05.2023.
//

import Foundation
import RijksmuseumDB

protocol CollectionProviding {
    var offset: Int {get set}
    var limit: Int {get set}
    func getCollection() async throws -> [ArtObject]
}

class CollectionProvider: CollectionProviding {
        
    var offset: Int = 0
    var limit: Int = 0
    
    private var provider: RMCollectionProvider
    
    init(_ configurator: AppConfigurating = AppConfigurator(), offset: Int = 1) {
        self.offset = 1
        self.limit = 10
        let language = configurator.language == RMLanguage.en.rawValue ? RMLanguage.en : RMLanguage.nl
        let settings = RMSettings(apiKey: configurator.netwrokConfiguraion.apiKey,
                                  language: language)
        self.provider = RMCollectionProvider(settings: settings, offset: offset)
    }
    
    func getCollection() async throws -> [ArtObject] {
        self.provider.setPage(offset: offset, limit: limit)
        let objects = try await self.provider.getCollection().compactMap {ArtObject.build(from: $0)}
        return objects
    }
}
