//
//  CollectionViewCellConfigurator.swift
//  Rijksmuseum
//
//  Created by Troian on 29.05.2023.
//

import Foundation

protocol CollectionViewCellConfigurating {
    
}

class CollectionViewCellConfigurator: CollectionViewCellConfigurating {
    
    var dataProvider: ColectionViewDataProvider
    
    init(dataProvider: ColectionViewDataProvider) {
        self.dataProvider = dataProvider
    }
    
}


