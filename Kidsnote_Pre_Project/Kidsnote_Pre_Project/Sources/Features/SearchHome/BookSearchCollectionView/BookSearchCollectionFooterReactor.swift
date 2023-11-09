//
//  BookSearchCollectionFooterReactor.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/09.
//

import ReactorKit
import RxRelay

final class BookSearchCollectionFooterReactor: Reactor {
    
    enum Action {
        case didStartLaoding(Bool)
    }
    
    enum Mutation {
        case setLoadingIndicatorIsAnimating(Bool)
    }
    
    struct State {
        var isLoadingIndicatorAnimating: Bool = false
    }
    
    var initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didStartLaoding(let isLoading):
            return .just(.setLoadingIndicatorIsAnimating(isLoading))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setLoadingIndicatorIsAnimating(let isAnimating):
            newState.isLoadingIndicatorAnimating = isAnimating
        }
        return newState
    }
}
