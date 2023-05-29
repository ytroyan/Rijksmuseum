//
//  CollectionInteractor.swift
//  Rijksmuseum
//
//  Created by Troian on 29.05.2023.
//

import Foundation

protocol CollectionViewInteracting {
    
}

protocol ColectionViewDataProvider {

}

class ColectionViewInteractor: CollectionViewInteracting {
    weak var delegate: MainInteractorDelegate?
    var presenter: CollectionViewPresenting
    
    init(delegate: MainInteractorDelegate? = nil, presenter: CollectionViewPresenting) {
        self.delegate = delegate
        self.presenter = presenter
    }
    
}

extension ColectionViewInteractor: ColectionViewDataProvider {
    
}
