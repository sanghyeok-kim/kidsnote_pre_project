//
//  BookSearchCollectionViewDiffableDataSource.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/05.
//

import UIKit

final class BookSearchDiffableDataSource: UICollectionViewDiffableDataSource<BookSearchSection, BookItem> {
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<BookSearchSection, BookItem>
    
    private let cellProvider = { (
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: BookItem
    ) -> UICollectionViewCell in
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BookSearchCollectionViewCell.identifier,
            for: indexPath
        ) as? BookSearchCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: item.bookEntity)
        return cell
    }
    
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView, cellProvider: cellProvider)
    }
    
    func configureHeaderView(reactor: BookSearchTypeCollectionHeaderReactor) {
        supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: BookSearchTypeCollectionHeaderView.identifier,
                for: indexPath
            ) as? BookSearchTypeCollectionHeaderView else { return UICollectionReusableView() }
            headerView.reactor = reactor
            return headerView
        }
    }
    
    func update(with items: [BookItem]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        apply(snapshot, animatingDifferences: true)
    }
}
