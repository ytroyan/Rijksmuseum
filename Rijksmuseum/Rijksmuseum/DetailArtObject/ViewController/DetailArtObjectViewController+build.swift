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
        let provider = DetailArtObjectProvider(artObjectId: artObjectId)
        let interactor = DetailArtObjectViewInteractor(delegate: delegate, presenter: presenter, provider: provider)
        let vc = DetailArtObjectViewController(interactor: interactor)
        presenter.viewController = vc
        return vc
    }
}
