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
        case bookSearchCollectionViewWillDisplay(IndexPath)
    }
    
    enum Mutation {
        case setBookSearchTypeHeaderReactor(BookSearchTypeCollectionHeaderReactor)
        case setBookSearchTypeFooterReactor(BookSearchCollectionFooterReactor)
        
        case setSelectedBookSearchType(BookSearchType)
        case setPaginationStateMap(forKey: BookSearchType, value: PaginationState)
        case clearAllPaginationStateMap
        case setFetchedBookItemsMap(forKey: BookSearchType, value: [BookItem])
        case clearFetehedBookItems(forKey: BookSearchType)
        case clearAllFetehedBookItemsMap
        case setBookSearchResultToShow([BookItem], shouldAppend: Bool = false)
        case clearBookSearchResultToShow
        case setFooterLoadingIndicatorLoading(Bool)
        
        case setSearchTextFieldFirstResponder(Bool)
        case setRefreshControlIsRefreshing(Bool)
        case setSearchBackgroundViewExpand(Bool)
        case setSearchKeyword(String)
        case setSearchKeywordIsEdited(Bool)
        case setCollectionViewIsHidden(Bool)
        case setLoadingIndicatorAnimating(Bool)
        case setFetchResultEmptyLabelHidden(Bool)
        case setTextFieldEmpty
        case setToastMessage(String)
    }
    
    struct State {
        var bookSearchTypeReactor: BookSearchTypeCollectionHeaderReactor?
        var loadingIndicatorFooterReactor: BookSearchCollectionFooterReactor?
        
        var selectedBookSearchType: BookSearchType = .allEbooks
        var paginationStateMap: [BookSearchType: PaginationState] = [:]
        var fetchedBookItemsMap: [BookSearchType: [BookItem]] = [:]
        var searchResultBookItemsToShow: [BookItem] = []
        var isFooterLoadingIndicatorLoading: Bool = false
        
        var isSearchTextFieldFirstResonder: Bool = false
        var isRefreshControlRefreshing: Bool = false
        var isSearchBackgroundViewExpanded: Bool = false
        var searchKeyword: String = ""
        var isSearchKeywordEdited: Bool = false
        var isBookSearchCollectionViewHidden: Bool = true
        var isLoadingIndicatorAnimating: Bool = false
        var shouldHideFetchResultEmptyLabel: Bool = true
        @Pulse var shouldClearTextFieldText: Bool = false
        @Pulse var toastMessage: String? = nil
    }
    
    let initialState = State()
    private let disposeBag = DisposeBag()
    
    private var currentSelectedPaginationState: PaginationState {
        return currentState.paginationStateMap[currentState.selectedBookSearchType, default: PaginationState()]
    }
    
    @Injected(AppDIContainer.shared) private var searchBookUseCase: SearchBookUseCase
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            let headerReactor = BookSearchTypeCollectionHeaderReactor()
            let footerReactor = BookSearchCollectionFooterReactor()
            bind(bookSearchTypeCollectionHeaderReactor: headerReactor)
            bind(bookSearchCollectionFooterReactor: footerReactor)
            return .concat(
                .just(.setBookSearchTypeHeaderReactor(headerReactor)),
                .just(.setBookSearchTypeFooterReactor(footerReactor))
            )
            
        case .viewDidRefresh:
            let initialPaginationState = PaginationState()
            return .concat(
                .just(.setPaginationStateMap(forKey: currentState.selectedBookSearchType, value: initialPaginationState)),
                .just(.clearFetehedBookItems(forKey: currentState.selectedBookSearchType)),
                .just(.clearBookSearchResultToShow),
                .just(.setRefreshControlIsRefreshing(true)),
                fetchBookSearchResult(
                    keyword: currentState.searchKeyword,
                    bookSearchType: currentState.selectedBookSearchType,
                    paginationState: initialPaginationState
                )
            )
        case .bookSearchBarDidTap:
            return .concat(
                .just(.setSearchBackgroundViewExpand(true)),
                .just(.setSearchTextFieldFirstResponder(true))
                .delay(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            )
        case .backButtonDidTap:
            return .concat(
                clearAllSearchConditions(),
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
            let paginationStateOfSelectedBookType = currentState.paginationStateMap[bookSearchType] ?? PaginationState()
            
            return .concat(
                .just(.setSelectedBookSearchType(bookSearchType)),
                .just(.setFetchedBookItemsMap(
                    forKey: currentState.selectedBookSearchType,
                    value: currentState.searchResultBookItemsToShow
                )),
                fetchBookSearchResultIfNeeded(
                    of: bookSearchType,
                    paginationState: paginationStateOfSelectedBookType
                )
            )
        case .searchTextFieldDidEdit(let keyword):
            return .concat(
                clearAllSearchConditions(),
                .just(.setFetchResultEmptyLabelHidden(true)),
                .just(.setSearchKeywordIsEdited(true)),
                .just(.setSearchKeyword(keyword)),
                .just(.setCollectionViewIsHidden(true))
            )
        case .searchTextFieldDidEndEditing:
            let keyword = currentState.searchKeyword
            
            if keyword.isEmpty || !currentState.isSearchKeywordEdited {
                return .empty()
            }
            
            let initialPaginationState = PaginationState()
            let currentSselectedBookSearchType = currentState.selectedBookSearchType
            return .concat(
                .just(.clearAllFetehedBookItemsMap),
                .just(.setLoadingIndicatorAnimating(true)),
                .just(.setPaginationStateMap(forKey: currentSselectedBookSearchType, value: initialPaginationState)),
                .just(.setCollectionViewIsHidden(false)),
                fetchBookSearchResult(
                    keyword: keyword,
                    bookSearchType: currentState.selectedBookSearchType,
                    paginationState: initialPaginationState
                )
            )
        case .bookSearchCollectionViewWillDisplay(let indexPath):
            let fetchedBookCount = currentState.searchResultBookItemsToShow.count
            let didDisplayLastCell = indexPath.row == fetchedBookCount - 1
            let canLoadMore = currentSelectedPaginationState.canLoadMore
            
            if didDisplayLastCell && canLoadMore {
                let paginationStateForNextPage = currentSelectedPaginationState.prepareNextPage()
                return .concat(
                    .just(.setPaginationStateMap(
                        forKey: currentState.selectedBookSearchType,
                        value: paginationStateForNextPage
                    )),
                    .just(.setFooterLoadingIndicatorLoading(canLoadMore)),
                    fetchBookSearchResult(
                        keyword: currentState.searchKeyword,
                        bookSearchType: currentState.selectedBookSearchType,
                        paginationState: paginationStateForNextPage,
                        shouldAppend: true
                    )
                )
            } else {
                return .empty()
            }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setBookSearchTypeHeaderReactor(let reactor):
            newState.bookSearchTypeReactor = reactor
        case .setBookSearchTypeFooterReactor(let reactor):
            newState.loadingIndicatorFooterReactor = reactor
            
        case .setSelectedBookSearchType(let type):
            newState.selectedBookSearchType = type
        case .setPaginationStateMap(let bookSearchType, let paginationState):
            newState.paginationStateMap[bookSearchType] = paginationState
        case .clearAllPaginationStateMap:
            newState.paginationStateMap = [:]
        case .setFetchedBookItemsMap(let key, let value):
            newState.fetchedBookItemsMap[key, default: []] = value
        case .clearFetehedBookItems(let bookSearchType):
            newState.fetchedBookItemsMap[bookSearchType] = []
        case .clearAllFetehedBookItemsMap:
            newState.fetchedBookItemsMap = [:]
        case .setBookSearchResultToShow(let bookItems, let shouldAppend):
            if shouldAppend {
                newState.searchResultBookItemsToShow.append(contentsOf: bookItems)
            } else {
                newState.searchResultBookItemsToShow = bookItems
            }
        case .clearBookSearchResultToShow:
            newState.searchResultBookItemsToShow = []
        case .setFooterLoadingIndicatorLoading(let isLoading):
            newState.isFooterLoadingIndicatorLoading = isLoading
            
        case .setSearchTextFieldFirstResponder(let isFirstResponder):
            newState.isSearchTextFieldFirstResonder = isFirstResponder
        case .setRefreshControlIsRefreshing(let isRefreshing):
            newState.isRefreshControlRefreshing = isRefreshing
        case .setSearchBackgroundViewExpand(let isExpanded):
            newState.isSearchBackgroundViewExpanded = isExpanded
        case .setSearchKeywordIsEdited(let isEdited):
            newState.isSearchKeywordEdited = isEdited
        case .setSearchKeyword(let keyword):
            newState.searchKeyword = keyword
        case .setCollectionViewIsHidden(let isHidden):
            newState.isBookSearchCollectionViewHidden = isHidden
        case .setLoadingIndicatorAnimating(let isAnimating):
            newState.isLoadingIndicatorAnimating = isAnimating
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

// MARK: - Bind Another Reactors

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
    
    func bind(bookSearchCollectionFooterReactor: BookSearchCollectionFooterReactor) {
        state.map { $0.isFooterLoadingIndicatorLoading }
            .distinctUntilChanged()
            .map { BookSearchCollectionFooterReactor.Action.didStartLaoding($0) }
            .bind(to: bookSearchCollectionFooterReactor.action)
            .disposed(by: disposeBag)
    }
}

// MARK: - Side Effect Methods

private extension SearchHomeReactor {
    func clearAllSearchConditions() -> Observable<Mutation> {
        return .concat(
            .just(.clearBookSearchResultToShow),
            .just(.clearAllFetehedBookItemsMap),
            .just(.clearAllPaginationStateMap)
        )
    }
    
    func fetchBookSearchResultIfNeeded(of bookSearchType: BookSearchType, paginationState: PaginationState) -> Observable<Mutation> {
        if let existingFetchResult = currentState.fetchedBookItemsMap[bookSearchType] {
            return .concat(
                .just(.setFetchResultEmptyLabelHidden(!existingFetchResult.isEmpty)),
                .just(.setBookSearchResultToShow(existingFetchResult))
            )
        } else {
            return .concat(
                .just(.setLoadingIndicatorAnimating(true)),
                .just(.setFetchResultEmptyLabelHidden(true)),
                .just(.clearBookSearchResultToShow),
                fetchBookSearchResult(
                    keyword: currentState.searchKeyword,
                    bookSearchType: bookSearchType,
                    paginationState: paginationState
                )
            )
        }
    }
    
    func fetchBookSearchResult(
        keyword: String,
        bookSearchType: BookSearchType,
        paginationState: PaginationState,
        shouldAppend: Bool = false
    ) -> Observable<Mutation> {
        return searchBookUseCase
            .searchBooks(keyword: keyword, bookSearchType: bookSearchType, paginationState: paginationState)
            .map { $0.map { BookItem(bookEntity: $0) } }
            .flatMap { result -> Observable<Mutation> in
                let shouldHideEmptyLabel = !(result.isEmpty && paginationState.currentIndex == .zero)
                let shouldFinishLoading = !result.isEmpty || paginationState.currentIndex == .zero
                var mutations: [Observable<Mutation>] = [
                    .just(.setFetchResultEmptyLabelHidden(shouldHideEmptyLabel)),
                    .just(.setRefreshControlIsRefreshing(false)),
                    .just(.setLoadingIndicatorAnimating(false)),
                    .just(.setFooterLoadingIndicatorLoading(false)),
                    .just(.setBookSearchResultToShow(result, shouldAppend: shouldAppend))
                ]
                if shouldFinishLoading {
                    mutations.append(
                        .just(.setPaginationStateMap(
                            forKey: bookSearchType,
                            value: paginationState.finishLoading(appendedItemCount: result.count)
                        ))
                    )
                }
                return .concat(mutations)
            }
            .catch { error in
                .concat(
                    .just(.setRefreshControlIsRefreshing(false)),
                    .just(.setLoadingIndicatorAnimating(false)),
                    .just(.setFooterLoadingIndicatorLoading(false)),
                    .just(.setToastMessage(ToastMessage.search(.failFetchingBookSearchResult).text)),
                    .just(.setPaginationStateMap(forKey: bookSearchType, value: paginationState.finishLoading()))
                )
            }
            .startWith(
                .setFetchResultEmptyLabelHidden(true),
                .setSearchKeywordIsEdited(false)
            )
    }
}
