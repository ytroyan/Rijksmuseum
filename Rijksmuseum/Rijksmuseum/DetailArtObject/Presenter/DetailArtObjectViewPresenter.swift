//
//  DetailArtObjectViewPresenter.swift
//  Rijksmuseum
//
//  Created by Troian on 01.06.2023.
//

import Foundation

protocol DetailArtObjectViewPresenting {
    func loaded(artObject: DetailArtObject)
    func loading()
    func emptyData()
}

class DetailArtObjectViewPresenter {
    weak var viewController: DetailArtObjectViewDisplaying?
}

extension DetailArtObjectViewPresenter: DetailArtObjectViewPresenting {
    func loading() {
        viewController?.updateState(.loading)
    }
    
    func emptyData() {
        viewController?.updateState(.empty)
    }
    
    func loaded(artObject: DetailArtObject) {
        viewController?.updateState(.loaded(title: artObject.title,
                                            longTitle: artObject.longTitle,
                                            image: artObject.image))
    }
}
