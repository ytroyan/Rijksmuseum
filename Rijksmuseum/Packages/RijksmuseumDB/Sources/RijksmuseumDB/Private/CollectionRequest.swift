//
//  Collection.swift
//  Rijksmuseum
//
//  Created by Troian on 28.05.2023.
//

import Foundation

struct CollectionRequest: RequestProtocol {
    var apiKey: String
    var language: String
    var page: Page
    var request: URLRequest {
        URLRequest(url: url)
    }
    var url: URL {
        guard let url = URL(string: requestString) else { fatalError()}
        return url
    }
        
    var requestString: String {
        "https://www.rijksmuseum.nl/api/\(language)/collection?key=\(apiKey)&ps=\(page.limit)&p=\(page.page)&s=\(RMSortResult.artist.rawValue)&imgonly=true"
    }
    
    init(apiKey: String, language: String, page: Int, limit: Int) {
        self.apiKey = apiKey
        self.language = language
        self.page = Page(page: page, limit: limit)
    }
    
    init(apiKey: String, language: String, page: Page) {
        self.apiKey = apiKey
        self.language = language
        self.page = page
    }
}



struct CollectionResponse: Codable {
    let count: Int
    let artObjects: [RMArtObject]
}
