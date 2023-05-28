//
//  RMArtObjectLoader.swift
//  Rijksmuseum
//
//  Created by Troian on 28.05.2023.
//

import Foundation

public class RMArtObjectLoader {
    private var settings: RMSettings
    private var urlSession: URLSession
    
    init(settings: RMSettings, urlSession: URLSession = .shared) {
        self.settings = settings
        self.urlSession = urlSession
    }
    
    func detailArtObject(for object: RMArtObject) async throws -> RMArtObject {
        let request: RequestProtocol =  ArtObjectRequest(apiKey: self.settings.apiKey,
                                                         language: self.settings.language,
                                                         objectNumber: object.objectNumber)
        let endpoint = Endpoint(request: request, responseType: ArtObjectResponse.self)
        return try await urlSession.getRequest(endpoint).artObject
    }
}
