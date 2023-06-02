//
//  AppSettings.swift
//  Rijksmuseum
//
//  Created by Troian on 29.05.2023.
//

import Foundation


protocol AppConfigurating {
    var language: String { get }
    var netwrokConfiguraion: NetwrokConfiguraion { get }
}

struct AppConfigurator: AppConfigurating {
    var language: String {
        "en"
    }
    
    var netwrokConfiguraion: NetwrokConfiguraion {
        NetwrokConfiguraion()
    }
}

struct NetwrokConfiguraion {
    var apiKey: String {
        "0fiuZFh4"
    }
}
