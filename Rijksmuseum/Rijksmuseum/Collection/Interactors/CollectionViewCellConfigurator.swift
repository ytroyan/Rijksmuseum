//
//  CollectionViewCellConfigurator.swift
//  Rijksmuseum
//
//  Created by Troian on 29.05.2023.
//

import Foundation
import UIKit


protocol CollectionViewCellConfigurating {
    var dataSource: UICollectionViewDiffableDataSource<String, ArtObject>! {get set}
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewCell, ArtObject> {get}
    var headerRegistration: UICollectionView.SupplementaryRegistration<CollectionHeaderView> {get}
    
    func registerReuseIdentifiers(for collectionView: UICollectionView)
    func updateCells()
}

class CollectionViewCellConfigurator: CollectionViewCellConfigurating {
    
    private let reuseCellIdentifier = "collectionCell"
    private let reuseSectionIdentifier = "SectionHeader"
    
    var dataSource: UICollectionViewDiffableDataSource<String, ArtObject>! = nil
    
    
    var dataProvider: ColectionViewDataProvider
    
    init(dataProvider: ColectionViewDataProvider) {
        self.dataProvider = dataProvider
    }
    
    func registerReuseIdentifiers(for collectionView: UICollectionView) {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseCellIdentifier)
        collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseSectionIdentifier)
    }
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewCell, ArtObject> {
        UICollectionView.CellRegistration<UICollectionViewCell, ArtObject> { (cell, indexPath, item) in
            print(item.id)
            var content = UIListContentConfiguration.subtitleCell()
            content.image = item.image
            content.directionalLayoutMargins = .zero
            content.axesPreservingSuperviewLayoutMargins = []
            content.secondaryText = item.title
            cell.contentConfiguration = content
            self.updateContent(item: item)
        }
    }
    
    func updateContent(item: ArtObject) {
        self.dataProvider.loadImage(for: item) { image in
            guard let image = image else {return}
            var updatedSnapshot = self.dataSource.snapshot()
            guard let datasourceIndex = updatedSnapshot.indexOfItem(item) else {return}
            let item = self.dataProvider.items[datasourceIndex]
            item.image = image
            updatedSnapshot.reloadItems([item])
            self.dataSource.apply(updatedSnapshot, animatingDifferences: true)
        }
    }
    
    var headerRegistration: UICollectionView.SupplementaryRegistration<CollectionHeaderView> {
        UICollectionView.SupplementaryRegistration<CollectionHeaderView>(elementKind: ElemeKinds.sectionHeaderElementKind) {
            (supplementaryView, elementKind, indexPath) in
            let uniques: Set<String> = Set(self.dataProvider.items.compactMap{"\($0.principalOrFirstMaker)"})
            let array = uniques.sorted()
            let sectionName: String = array[indexPath.section]
            supplementaryView.configure(with: sectionName)
        }
    }
    
    func updateCells() {
        var initialSnapshot = NSDiffableDataSourceSnapshot<String, ArtObject>()
        let uniques: Set<String> = Set(dataProvider.items.compactMap{"\($0.principalOrFirstMaker)"})
        let array = uniques.sorted()
        initialSnapshot.appendSections(array)
        for sectionType in array {
            let items =  dataProvider.items.filter {"\($0.principalOrFirstMaker)" == sectionType}
            initialSnapshot.appendItems(items, toSection: sectionType)
        }
        DispatchQueue.main.async {
            self.dataSource.apply(initialSnapshot, animatingDifferences: true)
        }
    }
}
