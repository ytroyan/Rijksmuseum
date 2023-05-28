//
//  RijksmuseumContent.swift
//  Rijksmuseum
//
//  Created by Troian on 28.05.2023.
//

import Foundation

public struct RMSettings {
    var apiKey: String
    var language: String
}

public class RMCollection {
    private var settings: RMSettings
    private var sortResult: RMSortResult
    private var page: Page
    private var urlSession: URLSession
    
    init(settings: RMSettings,
         sortResult: RMSortResult = .artist,
         offset: Int,
         limit: Int = 10, urlSession: URLSession = .shared) {
        self.settings = settings
        self.sortResult = sortResult
        self.page = Page(page: offset, limit: limit)
        self.urlSession = urlSession
    }
    
    func setSortResult(_ sortResult: RMSortResult) {
        self.sortResult = sortResult
    }
    
    func setPage(offset: Int, limit: Int) {
        self.page = Page(page: offset, limit: limit)
    }
    
    func getCollection() async throws -> [RMArtObject] {
        let request = CollectionRequest(apiKey: self.settings.apiKey, language: self.settings.language, page: self.page)
        let endpoint = Endpoint(request: request, responseType: CollectionResponse.self)
        return try await urlSession.getRequest(endpoint).artObjects
    }
}


