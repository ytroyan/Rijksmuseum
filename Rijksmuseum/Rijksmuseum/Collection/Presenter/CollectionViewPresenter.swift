//
//  CollectionPresenter.swift
//  Rijksmuseum
//
//  Created by Troian on 29.05.2023.
//

import Foundation

protocol CollectionViewPresenting {
    func started()
    func loading()
    func updated()
    func notFound()
}

class CollectionViewPresenter: CollectionViewPresenting {
    func notFound() {
        viewController?.statChanged(state: .notData)
    }
    
    func loading() {
        viewController?.statChanged(state: .loading)
    }
    
    weak var viewController: CollectionViewDisplaying?
    
    func started() {
        viewController?.display(title: "RijksMuseum")
    }
    
    func updated() {
        viewController?.statChanged(state: .loaded)
    }
}
