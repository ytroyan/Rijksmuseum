//
//  DetailArtObjectViewInteractor.swift
//  Rijksmuseum
//
//  Created by Troian on 01.06.2023.
//

import Foundation

protocol DetailArtObjectViewInteracting {
    
}


class DetailArtObjectViewInteractor: DetailArtObjectViewInteracting {
    weak var delegate: MainInteractorDelegate?
    var presenter: DetailArtObjectViewPresenting
    
    init(delegate: MainInteractorDelegate? = nil, presenter: DetailArtObjectViewPresenting) {
        self.delegate = delegate
        self.presenter = presenter
    }
    
}
