//
//  BookSearchCollectionViewSectionLayout.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/05.
//

import UIKit

public final class BookSearchCollectionViewSectionLayout: CollectionViewSectionProvidable {
    
    public init() { }
    
    private lazy var headerItem: NSCollectionLayoutBoundarySupplementaryItem = {
        let headerLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(100)
        )
        
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerLayoutSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        return headerItem
    }()
    
    private lazy var layoutItem: NSCollectionLayoutItem = {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(100)
        )
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutSize)
        return layoutItem
    }()
    
    private lazy var layoutGroup: NSCollectionLayoutGroup = {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(100)
        )
        let layoutGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: layoutSize,
            subitems: [layoutItem]
        )
        return layoutGroup
    }()
    
    public lazy var layoutSection: NSCollectionLayoutSection = {
        let sectionLayout = NSCollectionLayoutSection(group: layoutGroup)
        sectionLayout.contentInsets = NSDirectionalEdgeInsets(
            top: 24,
            leading: .zero,
            bottom: .zero,
            trailing: .zero
        )
        sectionLayout.boundarySupplementaryItems = [headerItem]
        return sectionLayout
    }()
}
