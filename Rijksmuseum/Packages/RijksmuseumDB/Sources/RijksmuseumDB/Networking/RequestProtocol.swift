//
//  RequestProtocol.swift
//  Rijksmuseum
//
//  Created by Troian on 28.05.2023.
//

import Foundation

protocol RequestProtocol {
    var request: URLRequest {get}
    var apiKey: String {get}
    var language: String {get}
}
