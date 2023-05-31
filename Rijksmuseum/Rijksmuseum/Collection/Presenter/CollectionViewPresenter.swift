//
//  CollectionPresenter.swift
//  Rijksmuseum
//
//  Created by Troian on 29.05.2023.
//

import Foundation

protocol CollectionViewPresenting {
    func didLoad()
    func itemsUpdated()
}

class CollectionViewPresenter: CollectionViewPresenting {
    weak var viewController: CollectionViewDisplaying?
    
    func didLoad() {
        viewController?.display(title: "RijksMuseum")
    }
    
    func itemsUpdated() {
        viewController?.itemsUpdated()
    }
}
