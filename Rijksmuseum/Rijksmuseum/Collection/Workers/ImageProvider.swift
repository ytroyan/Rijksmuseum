//
//  ImageProvider.swift
//  Rijksmuseum
//
//  Created by Troian on 31.05.2023.
//

import Foundation
import UIKit
import ImageStorage

protocol ImageProviding {
    func loadImage(for url: String) async throws -> UIImage?
}

class ImageProvider: ImageProviding {
    
    private let storage: ImageStoraging
    private let session: URLSession
    
    init(storage: ImageStoraging = ImageStorage(), session: URLSession = .shared) {
        self.storage = storage
        self.session = session
    }
    
    public func loadImage(for url: String) async throws -> UIImage? {
        if let image = storage.loadImage(for: url) {
            return image
        } else {
            guard let imageURL = URL(string: url) else { throw NSError(domain: "InvalidImage", code: 0, userInfo: nil) }

            let (data, _) = try await session.data(from: imageURL)
            guard let image = UIImage(data: data) else {
                throw NSError(domain: "InvalidImage", code: 0, userInfo: nil)
            }
            storage.save(image, for: url)
            return image
        }
    }
}
