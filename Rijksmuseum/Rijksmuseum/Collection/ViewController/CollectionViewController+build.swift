//
//  CollectionViewController+build.swift
//  Rijksmuseum
//
//  Created by Troian on 29.05.2023.
//

import Foundation

extension CollectionViewController {
    static func build(_ delegate: MainInteractorDelegate) -> CollectionViewController {
        let presenter = CollectionViewPresenter()
        let interactor = ColectionViewInteractor(delegate: delegate, presenter: presenter)
        let configurator = CollectionViewCellConfigurator(dataProvider: interactor)
        let vc = CollectionViewController(interactor: interactor, cellConfiguration: configurator)
        presenter.viewController = vc
        return vc
      
    }
}
