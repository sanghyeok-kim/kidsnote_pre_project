//
//  CollectionViewSectionProvidable.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/06.
//

import UIKit

public protocol CollectionViewSectionProvidable {
    var layoutSection: NSCollectionLayoutSection { get }
}

extension CollectionViewSectionProvidable {
    public func sectionProvider(
        _ section: Int,
        environment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection? {
        return layoutSection
    }
}
