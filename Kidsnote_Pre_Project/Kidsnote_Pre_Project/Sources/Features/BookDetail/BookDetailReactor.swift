//
//  BookDetailReactor.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/09.
//

import ReactorKit
import RxRelay

final class BookDetailReactor: Reactor {
    
    enum Action {
        case viewDidLoad
        case shareButtonDidTap
        case sampleButtonDidTap
        case downloadButtonDidTap
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var title: String
        var authors: String
        var publisher: String
        var publishedDate: String
        var description: String
        var isbn13Identifier: String
        var pageCount: Int
        var shareURL: URL?
        var thumbnailURL: URL?
        var isEbook: Bool
        var buyURL: URL?
        var sampleURL: URL?
    }
    
    let initialState: State
    
    private weak var coordinator: SearchHomeCoordinator?
    
    init(coordinator: SearchHomeCoordinator?, bookEntity: BookEntity) {
        self.coordinator = coordinator
        self.initialState = State(
            title: bookEntity.title,
            authors: bookEntity.authors,
            publisher: bookEntity.publisher,
            publishedDate: bookEntity.publishedDate.convertToDateFormatted(),
            description: bookEntity.description,
            isbn13Identifier: bookEntity.isbn13Identifier,
            pageCount: bookEntity.pageCount,
            shareURL: bookEntity.shareURL,
            thumbnailURL: bookEntity.thumbnailURL,
            isEbook: bookEntity.isEbook,
            buyURL: bookEntity.buyURL,
            sampleURL: bookEntity.sampleURL
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return .empty()
        case .shareButtonDidTap:
            let sharingURL = currentState.shareURL
            return openActivityViewController(url: sharingURL)
        case .sampleButtonDidTap:
            let url = currentState.sampleURL
            return openSmapleURL(url)
        case .downloadButtonDidTap:
            let url = currentState.buyURL
            return openSmapleURL(url)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            
        }
        return newState
    }
}

// MARK: - Side Effect Methods

private extension BookDetailReactor {
    func openSmapleURL(_ url: URL?) -> Observable<Mutation> {
        guard let url else {
            return .empty() // TODO: url 열 수 없을 때에 대한 mutation 리턴
        }
        coordinator?.coordinate(by: .openURL(url))
        return .empty()
    }
    
    func openActivityViewController(url: URL?) -> Observable<Mutation> {
        guard let url else {
            return .empty() // TODO: url 열 수 없을 때에 대한 mutation 리턴
        }
        coordinator?.coordinate(by: .openActivityViewController([url]))
        return .empty()
    }
}
