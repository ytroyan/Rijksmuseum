//
//  RijksmuseumContent.swift
//  Rijksmuseum
//
//  Created by Troian on 28.05.2023.
//

import Foundation

public class RMCollectionProvider {
    private var settings: RMSettings
    private var sortResult: RMSortResult
    private var page: Page
    private var urlSession: URLSession
    
    public init(settings: RMSettings,
                sortResult: RMSortResult = .artist,
                offset: Int,
                limit: Int = 10, urlSession: URLSession = .shared) {
        self.settings = settings
        self.sortResult = sortResult
        self.page = Page(page: offset, limit: limit)
        self.urlSession = urlSession
    }
    
    public func setSortResult(_ sortResult: RMSortResult) {
        self.sortResult = sortResult
    }
    
    public func setPage(offset: Int, limit: Int) {
        self.page = Page(page: offset, limit: limit)
    }
    
    public func getCollection() async throws -> [RMArtObject] {
        let request = CollectionRequest(apiKey: self.settings.apiKey, language: self.settings.language.rawValue, page: self.page)
        let endpoint = Endpoint(request: request, responseType: CollectionResponse.self)
        return try await urlSession.getRequest(endpoint).artObjects
    }
}


