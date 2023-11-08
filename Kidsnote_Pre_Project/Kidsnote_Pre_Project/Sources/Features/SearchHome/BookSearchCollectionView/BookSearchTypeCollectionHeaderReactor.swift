//
//  BookSearchTypeCollectionHeaderReactor.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/07.
//

import ReactorKit
import RxRelay

final class BookSearchTypeCollectionHeaderReactor: Reactor {
    
    enum Action {
        case bookSearchTypeDidSelect(index: Int)
    }
    
    enum Mutation {
        case setBookSearchType(index: Int)
    }
    
    struct State {
        var bookSearchTitles: [String] = BookSearchType.segmentTitles
        var selectedBookSearchType: BookSearchType = BookSearchType.allEbooks
    }
    
    var initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .bookSearchTypeDidSelect(let index):
            return .just(.setBookSearchType(index: index))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setBookSearchType(let index):
            newState.selectedBookSearchType = BookSearchType(rawValue: index) ?? .allEbooks
        }
        return newState
    }
}
