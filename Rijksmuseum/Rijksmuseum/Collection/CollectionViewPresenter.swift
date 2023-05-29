//
//  CollectionPresenter.swift
//  Rijksmuseum
//
//  Created by Troian on 29.05.2023.
//

import Foundation

protocol CollectionViewPresenting {
    
}

class CollectionViewPresenter: CollectionViewPresenting {
    weak var viewController: CollectionViewDisplaying?
}
