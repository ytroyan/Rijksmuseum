//
//  DetailArtObjectViewController.swift
//  Rijksmuseum
//
//  Created by Troian on 01.06.2023.
//

import UIKit

enum DetailArtObjectState {
    case loading, empty
    case loaded(title: String, longTitle: String, image: UIImage?)
}

protocol DetailArtObjectViewDisplaying: AnyObject {
    func updateState(_ state: DetailArtObjectState)
}

class DetailArtObjectViewController: UIViewController {
    
    private let interactor: DetailArtObjectViewInteracting
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var longTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var webLinkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("open", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.accessibilityIdentifier = "DetailArtObject.openButton"
        button.accessibilityLabel = "Open button"
        return button
    }()
    
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
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(longTitleLabel)
        view.addSubview(webLinkButton)
        webLinkButton.isHidden = true
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor), // Assuming square image
            
            longTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            longTitleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            longTitleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            webLinkButton.topAnchor.constraint(equalTo: longTitleLabel.bottomAnchor, constant: 40),
            webLinkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        interactor.viewDidLoad()
    }
    
   @objc func buttonTapped() {
       interactor.buttonTapped()
    }
    
}

extension DetailArtObjectViewController: DetailArtObjectViewDisplaying {
    func updateState(_ state: DetailArtObjectState) {
        switch state {
            case .loading:
                loadingState()
            case .empty:
                updateUIForEmpyState()
            case .loaded(title: let title, longTitle: let longTitle, image: let image):
                updateUI(for: title, longTitle: longTitle, image: image)
        }
    }
    
    func loadingState() {
        navigationItem.title = ""
        navigationItem.title = ""
        imageView.image = UIImage.animatedImage(for: "photo")
        webLinkButton.isHidden = true
    }
    
    func updateUIForEmpyState() {
        navigationItem.title = ""
        navigationItem.title = ""
        imageView.image = UIImage.emptyData
        webLinkButton.isHidden = true
    }
     
    func updateUI(for title: String, longTitle: String, image: UIImage?) {
        //title
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = title
        
        //longTitle
        longTitleLabel.text = longTitle
        
        //image
        imageView.image = image
        
        webLinkButton.isHidden = false
    }
}


