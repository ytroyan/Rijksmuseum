//
//  Endpoint.swift
//  Rijksmuseum
//
//  Created by Troian on 28.05.2023.
//

import Foundation


struct Endpoint<T> where T: Codable {
    let request: RequestProtocol
    let responseType: T.Type
}
