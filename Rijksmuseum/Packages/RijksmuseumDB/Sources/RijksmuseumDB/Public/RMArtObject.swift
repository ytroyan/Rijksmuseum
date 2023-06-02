//
//  ArtObject.swift
//  Rijksmuseum
//
//  Created by Troian on 28.05.2023.
//

import Foundation

public struct RMArtObject: Codable {
    public let id, objectNumber: String
    public let title, principalOrFirstMaker: String
    public let webImage: RMImage?
}
