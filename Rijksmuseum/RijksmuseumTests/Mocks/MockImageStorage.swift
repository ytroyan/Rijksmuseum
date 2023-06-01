//
//  MockImageStorage.swift
//  RijksmuseumTests
//
//  Created by Troian on 01.06.2023.
//

import Foundation
import ImageStorage
import UIKit

class MockImageStorage: ImageStoraging {
    var saved = false
    var image: UIImage?
    func save(_ object: UIImage, for key: String) {
        self.image = object
        saved = true
    }
    
    func loadImage(for key: String) -> UIImage? {
        return image
    }
}
