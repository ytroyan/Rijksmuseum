//
//  DetailArtObjectProvider.swift
//  Rijksmuseum
//
//  Created by Troian on 01.06.2023.
//

import Foundation
import RijksmuseumDB

protocol DetailArtObjectProviding {
    func getArtObject() async throws -> DetailArtObject
}

class DetailArtObjectProvider: DetailArtObjectProviding {

    private var provider: RMArtObjectProvider
    private var artObjectId: String!
    
    init(_ configurator: AppConfigurating = AppConfigurator(), artObjectId: String, session: URLSession = .shared) {
        let language = configurator.language == RMLanguage.en.rawValue ? RMLanguage.en : RMLanguage.nl
        let settings = RMSettings(apiKey: configurator.netwrokConfiguraion.apiKey,
                                  language: language)
        self.artObjectId = artObjectId
        self.provider = RMArtObjectProvider(settings: settings, urlSession: session)
    }
    
    func getArtObject() async throws -> DetailArtObject {
       let object =  try await self.provider.detailArtObject(for: artObjectId)
        return DetailArtObject.build(from: object)
    }
}
