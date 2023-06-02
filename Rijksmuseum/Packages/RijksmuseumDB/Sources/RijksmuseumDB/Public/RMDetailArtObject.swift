//
//  File.swift
//  
//
//  Created by Troian on 29.05.2023.
//

import Foundation

public struct RMDetailArtObject: Codable {
    public let id, objectNumber: String
    public let title: String
    public let description: String?
    public let principalMaker: String?
    public let principalOrFirstMaker: String?
    public let longTitle: String?
    public let location: String?
    public let webImage, headerImage: RMImage?
}
