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
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    let initialState = State()
    
    private let searchBookRepository: SearchBookRepository = DefaultSearchBookRepository()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            
        }
        return newState
    }
}
