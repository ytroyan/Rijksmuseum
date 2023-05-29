//
//  File.swift
//  
//
//  Created by Troian on 29.05.2023.
//

import Foundation

public enum RMLanguage: String {
    case en, nl
}

public struct RMSettings {
    var apiKey: String
    var language: RMLanguage
    
    public init(apiKey: String, language: RMLanguage = .nl) {
        self.apiKey = apiKey
        self.language = language
    }
}
