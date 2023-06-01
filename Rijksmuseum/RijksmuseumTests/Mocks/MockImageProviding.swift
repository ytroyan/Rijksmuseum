//
//  MockImageProviding.swift
//  RijksmuseumTests
//
//  Created by Troian on 01.06.2023.
//

import Foundation
import Rijksmuseum
import UIKit

class MockImageProviding: ImageProviding {
    var image: UIImage?
    var error: Error?
    func loadImage(for url: String) async throws -> UIImage? {
        if let error = self.error {
            throw error
        }
        return image
    }
}
