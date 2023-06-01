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
    func loadImage(for object: ArtObject, handler: ((UIImage?)->Void)?)
}


final class ColectionViewInteractor: CollectionViewInteracting {
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
        presenter.started()
        presenter.loading()
        Task {
            await fetchData()
            await MainActor.run(body: {
                itemsUpdated()
            })
        }
    }
    
    private func fetchData() async {
        do {
            items += try await self.dataProvider.getCollection()
        } catch {
            await MainActor.run(body: {
                delegate?.showAlertMessage(message: "\(error.localizedDescription)")
            })
        }
    }
    
    func collectionViewReachedEnd() {
        presenter.loading()
        self.dataProvider.offset += 1
        Task {
            await fetchData()
            await MainActor.run(body: {
                itemsUpdated()
            })
        }
    }
    
    private func itemsUpdated() {
        if !items.isEmpty {
            presenter.updated()
        } else {
            presenter.notFound()
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let id = ""
        self.delegate?.showDetailArtObject(id: id)
    }
}

extension ColectionViewInteractor: ColectionViewDataProvider {
    func loadImage(for object: ArtObject, handler: ((UIImage?) -> Void)?) {
        guard let urlString = object.imageURL, object.image == nil else {return}
        
        Task {
            let image = try? await imageProvider.loadImage(for: urlString)
            DispatchQueue.main.async {
                handler?(image)
            }
        }
    }
}





