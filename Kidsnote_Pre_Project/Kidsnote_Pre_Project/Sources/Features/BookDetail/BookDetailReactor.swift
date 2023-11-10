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
        case sampleButtonDidTap
        case downloadButtonDidTap
        case descriptonViewDidTap
    }
    
    enum Mutation {
        case setDescription(String)
        case setEmptyDescription
        case setReviewRank(Double)
        case setIsNotReviewedYet(Bool)
        case setIsDescriptionLoaded(Bool)
        case setIsReviewRankLoaded(Bool)
        case setLoadingIndicatorAnimating(Bool)
        case setToastMessage(String)
    }
    
    struct State {
        var id: String
        var title: String
        var authors: String
        var publisher: String
        var publishedDate: String
        var description: String = ""
        var isbn13Identifier: String
        var pageCount: Int
        var shareURL: URL?
        var thumbnailURL: URL?
        var isEbook: Bool
        var buyURL: URL?
        var sampleURL: URL?
        var reviewRank: Double?
        var isNotReviewedYet: Bool = false
        var isEmptyDescription: Bool = false
        var isDescriptionLoaded: Bool = false
        var isReviewRankLoaded: Bool = false
        var isLoadingIndicatorAnimating: Bool = false
        @Pulse var toastMessage: String? = nil
    }
    
    let initialState: State
    
    @Injected(AppDIContainer.shared) private var bookDetailInfoUseCase: BookDetailInfoUseCase
    @Injected(AppDIContainer.shared) private var bookRatingUseCase: BookRatingUseCase
    
    private weak var coordinator: SearchHomeCoordinator?
    
    init(coordinator: SearchHomeCoordinator?, bookEntity: BookEntity) {
        self.coordinator = coordinator
        self.initialState = State(
            id: bookEntity.id,
            title: bookEntity.title,
            authors: bookEntity.authors,
            publisher: bookEntity.publisher,
            publishedDate: bookEntity.publishedDate.convertToDateFormatted(),
            isbn13Identifier: bookEntity.isbn13Identifier,
            pageCount: bookEntity.pageCount,
            shareURL: bookEntity.shareURL,
            thumbnailURL: bookEntity.thumbnailURL,
            isEbook: bookEntity.isEbook,
            buyURL: bookEntity.buyURL,
            sampleURL: bookEntity.sampleURL
        )
    }
    
    // MARK: - Mutate
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return .concat(
                .just(.setLoadingIndicatorAnimating(true)),
                fetchDescription(id: currentState.id),
                fetchReviewRank(isbn13Id: currentState.isbn13Identifier)
            )
        case .sampleButtonDidTap:
            let url = currentState.sampleURL
            return openSmapleURL(url)
        case .downloadButtonDidTap:
            let url = currentState.buyURL
            return openSmapleURL(url)
        case .descriptonViewDidTap:
            let title = currentState.title
            let description = currentState.description
            return pushFullDescriptionViewController(title: title, description: description)
        }
    }
    
    // MARK: - Reduce
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setDescription(let desctiption):
            newState.description = desctiption
        case .setEmptyDescription:
            newState.isEmptyDescription = true
        case .setReviewRank(let reviewRank):
            newState.reviewRank = reviewRank
        case .setIsNotReviewedYet(let isNotReviewedYet):
            newState.isNotReviewedYet = isNotReviewedYet
        case .setIsDescriptionLoaded(let isDescriptionLoaded):
            newState.isDescriptionLoaded = isDescriptionLoaded
            newState.isLoadingIndicatorAnimating = !(isDescriptionLoaded && newState.isReviewRankLoaded)
        case .setIsReviewRankLoaded(let isReviewRankLoaded):
            newState.isReviewRankLoaded = isReviewRankLoaded
            newState.isLoadingIndicatorAnimating = !(isReviewRankLoaded && newState.isDescriptionLoaded)
        case .setLoadingIndicatorAnimating(let isAnimating):
            newState.isLoadingIndicatorAnimating = isAnimating
        case .setToastMessage(let message):
            newState.toastMessage = message
        }
        return newState
    }
}

// MARK: - Side Effect Methods

private extension BookDetailReactor {
    
    // MARK: - UseCase Methods
    
    func fetchDescription(id: String) -> Observable<Mutation> {
        return bookDetailInfoUseCase
            .fetchBookDetailInfo(bookId: id)
            .flatMap { detailInfo -> Observable<Mutation> in
                let descriptionText = detailInfo.description
                
                return .concat(
                    .just(.setIsDescriptionLoaded(true)),
                    .just(.setDescription(descriptionText))
                )
            }
            .catch { error in
                return .concat(
                    .just(.setIsDescriptionLoaded(true)),
                    .just(.setEmptyDescription)
                )
            }
    }
    
    func fetchReviewRank(isbn13Id: String) -> Observable<Mutation> {
        return bookRatingUseCase
            .fetchBookRating(isbn13Id: isbn13Id)
            .flatMap { reviewInfo -> Observable<Mutation> in
                let reviewRank = Double(reviewInfo.customerReviewRank) / 2.0
                return .concat(
                    .just(.setIsReviewRankLoaded(true)),
                    .just(.setReviewRank(reviewRank)),
                    .just(.setIsNotReviewedYet(reviewRank == .zero))
                )
            }
            .catch { _ in
                return .concat(
                    .just(.setIsReviewRankLoaded(true)),
                    .just(.setIsNotReviewedYet(true))
                )
            }
    }
    
    // MARK: - Coordinator Methods
    
    func openSmapleURL(_ url: URL?) -> Observable<Mutation> {
        guard let url else {
            return .just(.setToastMessage(ToastMessage.bookDetail(.failOpenSampleURL).text))
        }
        coordinator?.coordinate(by: .openURL(url))
        return .empty()
    }
    
    func openDownloadURL(_ url: URL?) -> Observable<Mutation> {
        guard let url else {
            return .just(.setToastMessage(ToastMessage.bookDetail(.failOpenDownloadURL).text))
        }
        coordinator?.coordinate(by: .openURL(url))
        return .empty()
    }
    
    func pushFullDescriptionViewController(title: String, description: String) -> Observable<Mutation> {
        coordinator?.coordinate(by: .pushFullDescriptionViewController(title: title, description: description))
        return .empty()
    }
}
