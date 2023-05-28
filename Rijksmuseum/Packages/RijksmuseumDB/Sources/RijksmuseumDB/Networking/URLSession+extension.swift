//
//  URLSession+extension.swift
//  Rijksmuseum
//
//  Created by Troian on 28.05.2023.
//

import Foundation

extension URLSession {
    func getRequest<T>(_ endpoint: Endpoint<T>) async throws -> T where T: Codable {
        let (data, response) = try await self.data(for: endpoint.request.request)
        if let response = response as? HTTPURLResponse,
           response.statusCode != 200 {
            throw NetworkError.unexpected(code: response.statusCode)
        }
        return try JSONDecoder().decode(endpoint.responseType, from: data)
    }
}


