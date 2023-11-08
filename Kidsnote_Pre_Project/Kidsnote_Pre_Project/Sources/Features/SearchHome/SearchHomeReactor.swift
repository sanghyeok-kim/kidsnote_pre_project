//
//  SearchHomeReactor.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import ReactorKit
import RxRelay

final class SearchHomeReactor: Reactor {
    
    enum Action {
        case viewDidLoad
        case viewDidRefresh
        case bookSearchBarDidTap
        case backButtonDidTap
        case bookSearchTypeDidSelect(BookSearchType)
        case searchTextFieldDidEdit(String)
        case searchTextFieldDidEndEditing
    }
    
    enum Mutation {
        case setBookSearchTypeHeaderReactor(BookSearchTypeCollectionHeaderReactor)
        case setSelectedBookSearchType(BookSearchType)
        case setBookItemsMap(forKey: BookSearchType, value: [BookItem])
        case setBookItemsMapClear
        case setSearchTextFieldFirstResponder(Bool)
        case setRefreshControlIsRefreshing(Bool)
        case setSearchBackgroundViewExpand(Bool)
        case setSearchKeyword(String)
        case setSearchKeywordIsEdited(Bool)
        case setBookSearchResult([BookItem])
        case setCollectionViewIsHidden(Bool)
        case setLoadingIndicatorAnimating(Bool)
        case setFetchResultIsEmpty(Bool)
        case setFetchResultEmptyLabelHidden(Bool)
        case setTextFieldEmpty
        case setToastMessage(String)
    }
    
    struct State {
        var bookSearchTypeReactor: BookSearchTypeCollectionHeaderReactor?
        var selectedBookSearchType: BookSearchType = .allEbooks
        var fetchedBookItemsMap: [BookSearchType: [BookItem]] = [:]
        var searchResultBookItemsToShow: [BookItem] = []
        var isRefreshControlRefreshing: Bool = false
        var isSearchTextFieldFirstResonder: Bool = false
        var isSearchBackgroundViewExpanded: Bool = false
        var isSearchKeywordEdited: Bool = false
        var searchKeyword: String = ""
        var isBookSearchCollectionViewHidden: Bool = true
        var isLoadingIndicatorAnimating: Bool = false
        var shouldHideFetchResultEmptyLabel: Bool = true
        @Pulse var shouldClearTextFieldText: Bool = false
        @Pulse var toastMessage: String? = nil
    }
    
    let initialState = State()
    private let disposeBag = DisposeBag()
    
    @Injected(AppDIContainer.shared) private var searchBookUseCase: SearchBookUseCase
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            let reactor = BookSearchTypeCollectionHeaderReactor()
            bind(bookSearchTypeCollectionHeaderReactor: reactor)
            return .just(.setBookSearchTypeHeaderReactor(reactor))
        case .viewDidRefresh:
            let keyword = currentState.searchKeyword
            return .concat(
                .just(.setRefreshControlIsRefreshing(true)),
                fetchBookSearchResult(keyword: keyword, bookSearchType: currentState.selectedBookSearchType)
            )
        case .bookSearchBarDidTap:
            return .concat(
                .just(.setSearchBackgroundViewExpand(true)),
                .just(.setSearchTextFieldFirstResponder(true))
                .delay(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            )
        case .backButtonDidTap:
            return .concat(
                .just(.setFetchResultEmptyLabelHidden(true)),
                .just(.setTextFieldEmpty),
                .just(.setCollectionViewIsHidden(true)),
                .just(.setSearchBackgroundViewExpand(false)),
                .just(.setSearchTextFieldFirstResponder(false))
            )
        case .bookSearchTypeDidSelect(let bookSearchType):
            if currentState.searchKeyword.isEmpty {
                return .empty()
            }
            return .concat(
                .just(.setSelectedBookSearchType(bookSearchType)),
                fetchBookSearchReulstIfNeeded(of: bookSearchType)
            )
        case .searchTextFieldDidEdit(let keyword):
            return .concat(
                .just(.setFetchResultEmptyLabelHidden(true)),
                .just(.setSearchKeywordIsEdited(true)),
                .just(.setBookSearchResult([])),
                .just(.setSearchKeyword(keyword)),
                .just(.setCollectionViewIsHidden(true))
            )
        case .searchTextFieldDidEndEditing:
            let keyword = currentState.searchKeyword
            
            if keyword.isEmpty || !currentState.isSearchKeywordEdited {
                return .empty()
            }
            
            return .concat(
                .just(.setBookItemsMapClear),
                .just(.setLoadingIndicatorAnimating(true)),
                .just(.setSearchTextFieldFirstResponder(true)),
                .just(.setCollectionViewIsHidden(false)),
                fetchBookSearchResult(keyword: keyword, bookSearchType: currentState.selectedBookSearchType)
            )
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setBookSearchTypeHeaderReactor(let reactor):
            newState.bookSearchTypeReactor = reactor
        case .setSelectedBookSearchType(let type):
            newState.selectedBookSearchType = type
        case .setBookItemsMap(let key, let value):
            newState.fetchedBookItemsMap[key] = value
        case .setBookItemsMapClear:
            newState.fetchedBookItemsMap = [:]
        case .setRefreshControlIsRefreshing(let isRefreshing):
            newState.isRefreshControlRefreshing = isRefreshing
        case .setSearchTextFieldFirstResponder(let isFirstResponder):
            newState.isSearchTextFieldFirstResonder = isFirstResponder
        case .setSearchBackgroundViewExpand(let isExpanded):
            newState.isSearchBackgroundViewExpanded = isExpanded
        case .setSearchKeyword(let keyword):
            newState.searchKeyword = keyword
        case .setSearchKeywordIsEdited(let isEdited):
            newState.isSearchKeywordEdited = isEdited
        case .setBookSearchResult(let bookItems):
            newState.searchResultBookItemsToShow = bookItems
        case .setCollectionViewIsHidden(let isHidden):
            newState.isBookSearchCollectionViewHidden = isHidden
        case .setLoadingIndicatorAnimating(let isAnimating):
            newState.isLoadingIndicatorAnimating = isAnimating
        case .setFetchResultIsEmpty(let isEmtpy):
            newState.shouldHideFetchResultEmptyLabel = isEmtpy
        case .setFetchResultEmptyLabelHidden(let isHidden):
            newState.shouldHideFetchResultEmptyLabel = isHidden
        case .setTextFieldEmpty:
            newState.shouldClearTextFieldText = true
        case .setToastMessage(let message):
            newState.toastMessage = message
        }
        return newState
    }
}

private extension SearchHomeReactor {
    func bind(bookSearchTypeCollectionHeaderReactor: BookSearchTypeCollectionHeaderReactor) {
        bookSearchTypeCollectionHeaderReactor.state
            .map { $0.selectedBookSearchType }
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .map { Action.bookSearchTypeDidSelect($0) }
            .bind(to: action)
            .disposed(by: disposeBag)
    }
}

// MARK: - Side Effect Methods

private extension SearchHomeReactor {
    func fetchBookSearchReulstIfNeeded(of bookSearchType: BookSearchType) -> Observable<Mutation> {
        guard let existingFetchResult = currentState.fetchedBookItemsMap[bookSearchType] else {
            return .concat(
                .just(.setBookSearchResult([])),
                .just(.setLoadingIndicatorAnimating(true)),
                .just(.setFetchResultEmptyLabelHidden(true)),
                fetchBookSearchResult(keyword: currentState.searchKeyword, bookSearchType: bookSearchType)
            )
        }
        return .concat(
            .just(.setFetchResultEmptyLabelHidden(!existingFetchResult.isEmpty)),
            .just(.setBookSearchResult(existingFetchResult))
        )
    }
    
    func fetchBookSearchResult(keyword: String, bookSearchType: BookSearchType) -> Observable<Mutation> {
        return searchBookUseCase
            .searchBooks(keyword: keyword, bookSearchType: bookSearchType, startIndex: 0, maxResults: 40)
            .map { $0.map { BookItem(bookEntity: $0) } }
            .flatMap { result -> Observable<Mutation> in
                return .concat(
                    .just(.setBookItemsMap(forKey: bookSearchType, value: result)),
                    .just(.setBookSearchResult(result)),
                    .just(.setFetchResultIsEmpty(result.isEmpty)),
                    .just(.setFetchResultEmptyLabelHidden(!result.isEmpty)),
                    .just(.setRefreshControlIsRefreshing(false)),
                    .just(.setLoadingIndicatorAnimating(false))
                )
            }
            .catch { error in
                .concat(
                    .just(.setToastMessage(ToastMessage.search(.failFetchingBookSearchResult).text)),
                    .just(.setRefreshControlIsRefreshing(false)),
                    .just(.setLoadingIndicatorAnimating(false))
                )
            }
            .startWith(
                .setFetchResultEmptyLabelHidden(true),
                .setSearchKeywordIsEdited(false)
            )
    }
}
