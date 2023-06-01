//
//  DetailArtObjectViewController+build.swift
//  Rijksmuseum
//
//  Created by Troian on 01.06.2023.
//

import Foundation

extension DetailArtObjectViewController {
    static func build(_ delegate: MainInteractorDelegate, artObjectId: String) -> DetailArtObjectViewController {
        let presenter = DetailArtObjectViewPresenter()
        let interactor = DetailArtObjectViewInteractor(delegate: delegate, presenter: presenter)
        let vc = DetailArtObjectViewController(interactor: interactor)
        presenter.viewController = vc
        return vc
        
    }
}
