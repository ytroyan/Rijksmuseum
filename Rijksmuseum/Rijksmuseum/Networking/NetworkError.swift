//
//  File.swift
//  Rijksmuseum
//
//  Created by Troian on 28.05.2023.
//

import Foundation

enum NetworkError: Error {
    case unexpected(code: Int)
}

extension NetworkError: CustomStringConvertible {
    public var description: String {
        switch self {
            case .unexpected(let code):
                return "An unexpected error occurred code \(code)"
        }
    }
    
    public var localizedDescription: String {
        description
    }
}
