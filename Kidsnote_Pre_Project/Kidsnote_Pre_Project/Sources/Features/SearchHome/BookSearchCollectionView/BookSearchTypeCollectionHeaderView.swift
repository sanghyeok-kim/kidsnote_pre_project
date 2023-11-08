//
//  BookSearchTypeCollectionHeaderView.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/05.
//

import UIKit

import ReactorKit

final class BookSearchTypeCollectionHeaderView: UICollectionReusableView, View {
    
    private let bookTypeSegmentControl = BookTypeSegmentControl()
    
    private let separatorView = SeparatorView()
    
    private let searchResultLabel: UILabel = {
        let label = UILabel()
        label.text = Literal.Text.googlePlaySearchResult
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookTypeSegmentControl.clearSelection()
        disposeBag = DisposeBag()
    }
    
    // MARK: - Bind Reactor
    
    func bind(reactor: BookSearchTypeCollectionHeaderReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
}

// MARK: - Bind Reactor

private extension BookSearchTypeCollectionHeaderView {
    func bindAction(reactor: BookSearchTypeCollectionHeaderReactor) {
        reactor.state.map { $0.bookSearchTitles }
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .bind(onNext: bookTypeSegmentControl.setTitles(_:))
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.selectedBookSearchType }
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .map { $0.index }
            .bind(onNext: bookTypeSegmentControl.selectSegment(at:))
            .disposed(by: disposeBag)
    }
    
    func bindState(reactor: BookSearchTypeCollectionHeaderReactor) {
        bookTypeSegmentControl.rx.selectedSegmentIndex
            .distinctUntilChanged()
            .map { Reactor.Action.bookSearchTypeDidSelect(index: $0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
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
