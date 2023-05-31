//
//  CollectionViewController.swift
//  Rijksmuseum
//
//  Created by Troian on 29.05.2023.
//

import UIKit

enum ElemeKinds {
    static let sectionHeaderElementKind = "sectionHeaderElementKind"
    static let sectionFooterElementKind = "sectionFooterElementKind"
}

class CollectionViewLayout: UICollectionViewCompositionalLayout {
        
    init() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20)
        let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(Appearance.sectionHeaderFont.lineHeight))
        let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: titleSize,
            elementKind: ElemeKinds.sectionHeaderElementKind,
            alignment: .top)
        
        section.boundarySupplementaryItems = [titleSupplementary]

        super.init(section: section)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

protocol CollectionViewDisplaying: AnyObject {
    func display(title: String)
    func itemsUpdated()
}

class CollectionViewController: UICollectionViewController {
    
    private let interactor: CollectionViewInteracting
    private var cellConfiguration: CollectionViewCellConfigurating
    
    required init(interactor: CollectionViewInteracting,
                  cellConfiguration: CollectionViewCellConfigurating,
                  collectionViewLayout: UICollectionViewLayout = CollectionViewLayout()) {
        self.interactor = interactor
        self.cellConfiguration = cellConfiguration
        super.init(collectionViewLayout: collectionViewLayout)
    }
        
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cellConfiguration.registerReuseIdentifiers(for: collectionView)

        let cellRegistration = self.cellConfiguration.cellRegistration
        self.cellConfiguration.dataSource = UICollectionViewDiffableDataSource<String, ArtObject>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: ArtObject) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        let headerRegistration = self.cellConfiguration.headerRegistration
        self.cellConfiguration.dataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
        collectionView.delegate = self
        interactor.viewDidLoad()

    }
     
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor.didSelectItem(at: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section ==  collectionView.numberOfSections - 1,
           indexPath.item == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
            interactor.collectionViewReachedEnd()
        }
    }
    
}

extension CollectionViewController: CollectionViewDisplaying {
    
    func display(title: String) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = title
    }
    
    func itemsUpdated() {
        self.cellConfiguration.updateCells()
    }
}


