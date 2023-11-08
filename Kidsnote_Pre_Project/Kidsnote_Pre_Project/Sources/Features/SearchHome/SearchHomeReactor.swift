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
        case searchTextFieldDidEdit(String)
        case searchTextFieldDidEndEditing
    }
    
    enum Mutation {
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
        var isRefreshControlRefreshing: Bool = false
        var isSearchTextFieldFirstResonder: Bool = false
        var isSearchBackgroundViewExpanded: Bool = false
        var isSearchKeywordEdited: Bool = false
        var searchKeyword: String = ""
        var fetchedBookSearchResult: [BookItem] = []
        var isBookSearchCollectionViewHidden: Bool = true
        var isLoadingIndicatorAnimating: Bool = false
        var shouldHideFetchResultEmptyLabel: Bool = true
        @Pulse var shouldClearTextFieldText: Bool = false
        @Pulse var toastMessage: String? = nil
    }
    
    let initialState = State()
    
    @Injected(AppDIContainer.shared) private var searchBookUseCase: SearchBookUseCase
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return .empty()
        case .viewDidRefresh:
            let keyword = currentState.searchKeyword
            return .concat(
                .just(.setRefreshControlIsRefreshing(true)),
                fetchBookSearchResult(keyword: keyword)
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
                .just(.setLoadingIndicatorAnimating(true)),
                .just(.setSearchTextFieldFirstResponder(true)),
                .just(.setCollectionViewIsHidden(false)),
                fetchBookSearchResult(keyword: keyword)
            )
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
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
            newState.fetchedBookSearchResult = bookItems
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

// MARK: - Side Effect Methods

private extension SearchHomeReactor {
    func fetchBookSearchResult(keyword: String) -> Observable<Mutation> {
        return searchBookUseCase
            .searchBooks(keyword: keyword, startIndex: 0, maxResults: 40)
            .map { $0.map { BookItem(bookEntity: $0) } }
            .flatMap { result -> Observable<Mutation> in
                if result.isEmpty {
                    return .concat(
                        .just(.setFetchResultIsEmpty(true)),
                        .just(.setFetchResultEmptyLabelHidden(false)),
                        .just(.setRefreshControlIsRefreshing(false)),
                        .just(.setLoadingIndicatorAnimating(false))
                    )
                } else {
                    return .concat(
                        .just(.setRefreshControlIsRefreshing(false)),
                        .just(.setBookSearchResult(result)),
                        .just(.setLoadingIndicatorAnimating(false))
                    )
                }
            }
            .catch { error in
                .concat(
                    .just(.setToastMessage(ToastMessage.Search.failFetchingBookSearchResult)),
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
