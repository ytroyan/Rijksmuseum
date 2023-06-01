//
//  DetailArtObjectViewController.swift
//  Rijksmuseum
//
//  Created by Troian on 01.06.2023.
//

import UIKit


protocol DetailArtObjectViewDisplaying: AnyObject {
    func display(title: String)
    func reloadData()
}

class DetailArtObjectViewController: UIViewController {
    
    private let interactor: DetailArtObjectViewInteracting
    
    required init(interactor: DetailArtObjectViewInteracting) {
        
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DetailArtObjectViewController: DetailArtObjectViewDisplaying {
    func display(title: String) {
        
    }
    
    func reloadData() {
        
    }
}


