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
    }
    
    enum Mutation {
        case setSearchTextFieldFirstResponder(Bool)
        case setSearchBackgroundViewExpand(Bool)
    }
    
    struct State {
        
        var isSearchTextFieldFirstResonder: Bool = false
        var isSearchBackgroundViewExpanded: Bool = false
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
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setSearchTextFieldFirstResponder(let isFirstResponder):
            newState.isSearchTextFieldFirstResonder = isFirstResponder
        case .setSearchBackgroundViewExpand(let isExpanded):
            newState.isSearchBackgroundViewExpanded = isExpanded
        }
        return newState
    }
}
