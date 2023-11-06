//
//  BookSearchTypeCollectionHeaderView.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/05.
//

import UIKit

final class BookSearchTypeCollectionHeaderView: UICollectionReusableView {
    
    private let bookTypeSegmentControl: BookTypeSegmentControl = {
        let segmentControl = BookTypeSegmentControl()
        segmentControl.setTitles(["전체 eBook", "무료 eBook"])
        segmentControl.selectSegment(at: .zero)
        return segmentControl
    }()
    
    private let separatorView = SeparatorView()
    
    private let searchResultLabel: UILabel = {
        let label = UILabel()
        label.text = "Google Play 검색결과"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Layout

private extension BookSearchTypeCollectionHeaderView {
    func layoutUI() {
        addSubview(bookTypeSegmentControl)
        addSubview(separatorView)
        addSubview(searchResultLabel)
        
        bookTypeSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        bookTypeSegmentControl.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bookTypeSegmentControl.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bookTypeSegmentControl.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.topAnchor.constraint(equalTo: bookTypeSegmentControl.bottomAnchor).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        searchResultLabel.translatesAutoresizingMaskIntoConstraints = false
        searchResultLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 12).isActive = true
        searchResultLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive = true
        searchResultLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18).isActive = true
        searchResultLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
