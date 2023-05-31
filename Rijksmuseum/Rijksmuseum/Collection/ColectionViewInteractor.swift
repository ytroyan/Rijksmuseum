//
//  CollectionInteractor.swift
//  Rijksmuseum
//
//  Created by Troian on 29.05.2023.
//

import Foundation
import UIKit


protocol CollectionViewInteracting {
    func viewDidLoad()
    func collectionViewReachedEnd()
    func didSelectItem(at indexPath: IndexPath)
}

protocol ColectionViewDataProvider {
    var items: [ArtObject] {get}
}


class ColectionViewInteractor: CollectionViewInteracting {
    weak var delegate: MainInteractorDelegate?
    
    var presenter: CollectionViewPresenting
    var dataProvider: CollectionProviding
    var imageProvider: ImageProviding
    
    var items: [ArtObject] = []
    
    init(delegate: MainInteractorDelegate? = nil,
         presenter: CollectionViewPresenting,
         provider: CollectionProviding = CollectionProvider(),
         imageProvider: ImageProviding = ImageProvider()) {
        self.delegate = delegate
        self.presenter = presenter
        self.dataProvider = provider
        self.imageProvider = imageProvider
    }
   
    
    func viewDidLoad() {
        presenter.didLoad()
        Task {
            await fetchData()
            await MainActor.run(body: {
                presenter.itemsUpdated()
            })
        }
    }
    
    func fetchData() async {
       
        do {
            items = try await self.dataProvider.getCollection()
        } catch {
            await MainActor.run(body: {
                delegate?.showAlertMessage(message: "\(error.localizedDescription)")
            })
        }
    }
    
    func collectionViewReachedEnd() {
        self.dataProvider.limit += 1
//        Task {
//            await fetchData()
//            await MainActor.run(body: {
//                presenter.itemsUpdated()
//            })
//        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let id = ""
        self.delegate?.showDetailArtObject(id: id)
    }
}

extension ColectionViewInteractor: ColectionViewDataProvider {
    
}





