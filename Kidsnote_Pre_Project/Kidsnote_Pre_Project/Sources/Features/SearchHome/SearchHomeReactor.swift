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
        case bookSearchBarDidTap
        case backButtonDidTap
    }
    
    enum Mutation {
        case setSearchTextFieldFirstResponder(Bool)
        case setSearchBackgroundViewExpand(Bool)
        case setCollectionViewIsHidden(Bool)
        case setFetchResultIsEmpty(Bool)
        case setFetchResultEmptyLabelHidden(Bool)
        case setTextFieldEmpty
    }
    
    struct State {
        var isSearchTextFieldFirstResonder: Bool = false
        var isSearchBackgroundViewExpanded: Bool = false
        var isBookSearchCollectionViewHidden: Bool = true
    }
    
    let initialState = State()
    
    private let searchBookRepository: SearchBookRepository = DefaultSearchBookRepository()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return .empty()
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
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setSearchTextFieldFirstResponder(let isFirstResponder):
            newState.isSearchTextFieldFirstResonder = isFirstResponder
        case .setSearchBackgroundViewExpand(let isExpanded):
            newState.isSearchBackgroundViewExpanded = isExpanded
        case .setCollectionViewIsHidden(let isHidden):
            newState.isBookSearchCollectionViewHidden = isHidden
        case .setFetchResultIsEmpty(let isEmtpy):
            newState.shouldHideFetchResultEmptyLabel = isEmtpy
        case .setFetchResultEmptyLabelHidden(let isHidden):
            newState.shouldHideFetchResultEmptyLabel = isHidden
        case .setTextFieldEmpty:
            newState.shouldClearTextFieldText = true
        }
        return newState
    }
}
