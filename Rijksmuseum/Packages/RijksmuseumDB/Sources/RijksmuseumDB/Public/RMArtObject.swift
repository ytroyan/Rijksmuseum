//
//  ArtObject.swift
//  Rijksmuseum
//
//  Created by Troian on 28.05.2023.
//

import Foundation


// MARK: - ArtObjectClass
public struct RMArtObject: Codable {
    let id, objectNumber: String
    let title: String
    let titles: [String]?
    let description: String?
    let objectTypes, objectCollection: [String]?
    let plaqueDescriptionDutch, plaqueDescriptionEnglish, principalMaker: String?
    let materials, techniques, productionPlaces: [String]?
    let hasImage: Bool?
    let historicalPersons: [String]?
    let principalOrFirstMaker: String?
    let physicalMedium, longTitle, subTitle, scLabelLine: String?
    let showImage: Bool?
    let location: String?
}
