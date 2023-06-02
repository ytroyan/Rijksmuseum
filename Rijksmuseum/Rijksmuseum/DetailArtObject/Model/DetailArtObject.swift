//
//  DetailArtObject.swift
//  Rijksmuseum
//
//  Created by Troian on 01.06.2023.
//

import Foundation
import RijksmuseumDB
import UIKit

class DetailArtObject: Hashable {
    var id: String
    var objectNumber: String
    var title: String
    var longTitle: String
    var imageURL: String?
    var image: UIImage?
    
    init(id: String,
         objectNumber: String,
         title: String,
         longTitle: String,
         imageURL: String? = nil) {
        self.id = id
        self.objectNumber = objectNumber
        self.title = title
        self.longTitle = longTitle
        self.imageURL = imageURL
    }
    
    static func == (lhs: DetailArtObject, rhs: DetailArtObject) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension DetailArtObject {
    static func build(from object: RMDetailArtObject) -> DetailArtObject {
        DetailArtObject(id: object.id,
                        objectNumber: object.objectNumber,
                        title: object.title,
                        longTitle: object.longTitle ?? "",
                        imageURL: object.webImage?.url)
    }
}
//TODO: refactor it
extension DetailArtObject {
    var webLink: String {
        "http://www.rijksmuseum.nl/nl/collectie/\(objectNumber)"
    }
}
