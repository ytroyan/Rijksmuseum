//
//  ArtObjectRequest.swift
//  Rijksmuseum
//
//  Created by Troian on 28.05.2023.
//

import Foundation

struct DetailArtObjectRequest: RequestProtocol {
    var apiKey: String
    var language: String
    let objectNumber: String
    
    var request: URLRequest {
        URLRequest(url: url)
    }
    
   private var url: URL {
        guard let url = URL(string: requestString) else {fatalError()}
        return url
    }
    
    private var requestString: String {
        "https://www.rijksmuseum.nl/api/\(language)/collection/\(objectNumber)?key=\(apiKey)"
    }
    
    init(apiKey: String, language: String, objectNumber: String) {
        self.apiKey = apiKey
        self.language = language
        self.objectNumber = objectNumber
    }
}

struct DetailArtObjectResponse: Codable {
    let artObject: RMDetailArtObject
}
