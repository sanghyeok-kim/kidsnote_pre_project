//
//  SearchHomeViewController.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import UIKit

import ReactorKit
import RxCocoa
import RxSwift

final class SearchHomeViewController: BaseViewController, View {
    
    private let dimmingSearchBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.alpha = .zero
        return view
    }()
    
    private let expandableSearchBackgroundView = ShadowView()
    
    private let searchView: SearchView = {
        let view = SearchView()
        view.alpha = .zero
        return view
    }()
    
    private let bookSearchBar = BookSearchBar()
    
    private let bookSearchRefreshControl = UIRefreshControl()
    
    private lazy var bookSearchDiffableDataSource = BookSearchDiffableDataSource(
        collectionView: bookSearchCollectionView
    )
    private let bookSearchCollectionViewSectionLayout = BookSearchCollectionViewSectionLayout()
    private lazy var bookSearchCollectionViewLayout: UICollectionViewCompositionalLayout = {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let compositionalLayout = UICollectionViewCompositionalLayout(
            sectionProvider: bookSearchCollectionViewSectionLayout.sectionProvider,
            configuration: configuration
        )
        return compositionalLayout
    }()
    private lazy var bookSearchCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: bookSearchCollectionViewLayout
        )
        collectionView.register(
            BookSearchCollectionViewCell.self,
            forCellWithReuseIdentifier: BookSearchCollectionViewCell.identifier
        )
        collectionView.register(
            BookSearchTypeCollectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: BookSearchTypeCollectionHeaderView.identifier
        )
        collectionView.refreshControl = bookSearchRefreshControl
        collectionView.isHidden = true
        return collectionView
    }()
    
    private let searchResultEmptyLabel = SearchResultEmptyLabel()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private let toastLabel = ToastLabel()
    
    // MARK: - Constraint Properties
    
    lazy var searchBackgroundViewExpandedConstraints: [NSLayoutConstraint] = {
        return [
            expandableSearchBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            expandableSearchBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            expandableSearchBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            expandableSearchBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
    }()
    
    lazy var searchBackgroundViewCollapsedConstraints: [NSLayoutConstraint] = {
        return [
            expandableSearchBackgroundView.topAnchor.constraint(equalTo: bookSearchBar.topAnchor),
            expandableSearchBackgroundView.leadingAnchor.constraint(equalTo: bookSearchBar.leadingAnchor),
            expandableSearchBackgroundView.trailingAnchor.constraint(equalTo: bookSearchBar.trailingAnchor),
            expandableSearchBackgroundView.bottomAnchor.constraint(equalTo: bookSearchBar.bottomAnchor)
        ]
    }()
    
    var disposeBag = DisposeBag()
    
    // MARK: - Bind Reactor
    
    func bind(reactor: SearchHomeReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    // MARK: - Configure UI
    
    override func configureUI() {
        super.configureUI()
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Layout UI
    
    override func layoutUI() {
        super.layoutUI()
        
        view.addSubview(dimmingSearchBackgroundView)
        searchView.addSubview(bookSearchCollectionView)
        view.addSubview(expandableSearchBackgroundView)
        view.addSubview(bookSearchBar)
        view.addSubview(searchView)
        bookSearchCollectionView.addSubview(searchResultEmptyLabel)
        view.addSubview(loadingIndicator)
        view.addSubview(toastLabel)
        
        dimmingSearchBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        dimmingSearchBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dimmingSearchBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        dimmingSearchBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dimmingSearchBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        expandableSearchBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(searchBackgroundViewCollapsedConstraints)
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        searchView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        bookSearchBar.translatesAutoresizingMaskIntoConstraints = false
        bookSearchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        bookSearchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
        bookSearchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12).isActive = true
        
        bookSearchCollectionView.translatesAutoresizingMaskIntoConstraints = false
        bookSearchCollectionView.topAnchor.constraint(equalTo: bookSearchBar.bottomAnchor).isActive = true
        bookSearchCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bookSearchCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bookSearchCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        toastLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32).isActive = true
        
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        searchResultEmptyLabel.translatesAutoresizingMaskIntoConstraints = false
        searchResultEmptyLabel.centerXAnchor.constraint(equalTo: bookSearchCollectionView.centerXAnchor).isActive = true
        searchResultEmptyLabel.topAnchor.constraint(equalTo: bookSearchCollectionView.topAnchor, constant: 200).isActive = true
    }
}

// MARK: - Bind Reactor

private extension SearchHomeViewController {
    func bindAction(reactor: SearchHomeReactor) {
        rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        bookSearchRefreshControl.rx.controlEvent(.valueChanged)
            .map { Reactor.Action.viewDidRefresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        bookSearchBar.rx.tap
            .map { Reactor.Action.bookSearchBarDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        searchView.backButton.rx.tap
            .map { Reactor.Action.backButtonDidTap }
            .debug()
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        searchView.searchBookTextField.rx.textChanged
            .map { Reactor.Action.searchTextFieldDidEdit($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        searchView.searchBookTextField.rx.controlEvent(.editingDidEndOnExit)
            .map { Reactor.Action.searchTextFieldDidEndEditing }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    func bindState(reactor: SearchHomeReactor) {
        
        reactor.state.map { $0.isRefreshControlRefreshing }
            .distinctUntilChanged()
            .bind(to: bookSearchRefreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isSearchTextFieldFirstResonder }
            .distinctUntilChanged()
            .bind(to: searchView.searchBookTextField.rx.shouldBecomeFirstResponder)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isSearchBackgroundViewExpanded }
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .bind(onNext: toggleSearchView(shouldExpand:))
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.fetchedBookSearchResult }
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .bind(onNext: bookSearchDiffableDataSource.update(with:))
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isBookSearchCollectionViewHidden }
            .distinctUntilChanged()
            .bind(to: bookSearchCollectionView.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isBookSearchCollectionViewHidden }
            .distinctUntilChanged()
            .bind(to: bookSearchCollectionView.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoadingIndicatorAnimating }
            .distinctUntilChanged()
            .bind(to: loadingIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.shouldHideFetchResultEmptyLabel }
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .bind(onNext: searchResultEmptyLabel.setVisibility(shouldHide:))
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoadingIndicatorAnimating }
            .distinctUntilChanged()
            .bind(to: loadingIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$shouldClearTextFieldText)
            .filter { $0 }
            .map { _ in "" }
            .bind(to: searchView.searchBookTextField.rx.text)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$toastMessage)
            .compactMap { $0 }
            .observe(on: MainScheduler.asyncInstance)
            .bind(onNext: toastLabel.show(message:))
            .disposed(by: disposeBag)
    }
}

// MARK: - Animating Methods

private extension SearchHomeViewController {
    func toggleSearchView(shouldExpand: Bool) {
        if shouldExpand {
            NSLayoutConstraint.deactivate(searchBackgroundViewCollapsedConstraints)
            NSLayoutConstraint.activate(searchBackgroundViewExpandedConstraints)
        } else {
            NSLayoutConstraint.deactivate(searchBackgroundViewExpandedConstraints)
            NSLayoutConstraint.activate(searchBackgroundViewCollapsedConstraints)
        }
        
        UIView.animate(withDuration: 0.35) { [weak self] in
            self?.searchView.alpha = shouldExpand ? 1.0 : .zero
            self?.dimmingSearchBackgroundView.alpha = shouldExpand ? 0.5 : .zero
            self?.bookSearchBar.alpha = shouldExpand ? .zero : 1.0
            self?.view.layoutIfNeeded()
        }
    }
}
