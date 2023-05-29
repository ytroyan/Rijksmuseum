//
//  RMArtObjectLoader.swift
//  Rijksmuseum
//
//  Created by Troian on 28.05.2023.
//

import Foundation

public class RMArtObjectProvider {
    private var settings: RMSettings
    private var urlSession: URLSession
    
    public  init(settings: RMSettings, urlSession: URLSession = .shared) {
        self.settings = settings
        self.urlSession = urlSession
    }
    
    public func detailArtObject(for objectNumber: String) async throws -> RMDetailArtObject {
        let request: RequestProtocol =  DetailArtObjectRequest(apiKey: self.settings.apiKey,
                                                         language: self.settings.language.rawValue,
                                                         objectNumber: objectNumber)
        let endpoint = Endpoint(request: request, responseType: DetailArtObjectResponse.self)
        return try await urlSession.getRequest(endpoint).artObject
    }
}
