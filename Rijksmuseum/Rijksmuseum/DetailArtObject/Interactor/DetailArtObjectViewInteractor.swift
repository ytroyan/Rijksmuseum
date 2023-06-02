//
//  DetailArtObjectViewInteractor.swift
//  Rijksmuseum
//
//  Created by Troian on 01.06.2023.
//

import Foundation
import RijksmuseumDB
import UIKit

protocol DetailArtObjectViewInteracting {
    func viewDidLoad()
    func buttonTapped()
}


class DetailArtObjectViewInteractor {
    weak var delegate: MainInteractorDelegate?
    var presenter: DetailArtObjectViewPresenting!
    
    private var provider: DetailArtObjectProviding!
    private var imageProvider: ImageProviding!
    private var detailArtObject: DetailArtObject?
    
    init(delegate: MainInteractorDelegate? = nil,
         presenter: DetailArtObjectViewPresenting,
         provider: DetailArtObjectProviding,
         imageProvider: ImageProvider = ImageProvider())
    {
        self.delegate = delegate
        self.presenter = presenter
        self.provider = provider
        self.imageProvider = imageProvider
    }
    
    func fetchData() async {
        do {
            detailArtObject = try await self.provider.getArtObject()
            if let url = detailArtObject?.imageURL  {
                detailArtObject?.image = try await self.imageProvider.loadImage(for: url)
            }
        } catch {
            await MainActor.run(body: {
                delegate?.showAlertMessage(message: "\(error.localizedDescription)")
            })
        }
    }
}

extension DetailArtObjectViewInteractor: DetailArtObjectViewInteracting {
    
    func buttonTapped() {
        if let link = detailArtObject?.webLink,
           let url = URL(string: link) {
            UIApplication.shared.open(url)
        }
    }
    
    func viewDidLoad() {
        self.presenter.loading()
        Task {
            await fetchData()
            await MainActor.run(body: {
                guard let detailArtObject = self.detailArtObject else {
                    self.presenter.emptyData()
                    return
                }
                self.presenter.loaded(artObject: detailArtObject)
            })
        }
    }
}

