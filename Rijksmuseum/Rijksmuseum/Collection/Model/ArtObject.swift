//
//  ArtObject.swift
//  Rijksmuseum
//
//  Created by Troian on 31.05.2023.
//

import Foundation
import RijksmuseumDB
import UIKit

class ArtObject: Hashable {
    var id: String
    var objectNumber: String
    var title: String
    var principalOrFirstMaker: String
    var imageURL: String?
    
    var image: UIImage?
    
    init(id: String,
         objectNumber: String,
         title: String,
         principalOrFirstMaker: String,
         imageURL: String? = nil) {
        self.id = id
        self.objectNumber = objectNumber
        self.title = title
        self.principalOrFirstMaker = principalOrFirstMaker
        self.imageURL = imageURL
    }
    
    static func == (lhs: ArtObject, rhs: ArtObject) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ArtObject {
    static func build(from object: RMArtObject) -> ArtObject {
        ArtObject(id: object.id,
                  objectNumber: object.objectNumber,
                  title: object.title,
                  principalOrFirstMaker: object.principalOrFirstMaker,
                  imageURL: object.webImage?.url)
    }
}
