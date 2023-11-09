//
//  LoadingIndicatorFooterView.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/09.
//

import ReactorKit
import RxCocoa
import RxSwift

final class LoadingIndicatorFooterView: UICollectionReusableView, View {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    // MARK: - Bind Reactor
    
    func bind(reactor: BookSearchCollectionFooterReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
}

// MARK: - Bind Reactor

private extension LoadingIndicatorFooterView {
    func bindAction(reactor: BookSearchCollectionFooterReactor) {
        reactor.state.map { $0.isLoadingIndicatorAnimating }
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
    func bindState(reactor: BookSearchCollectionFooterReactor) { }
}



// MARK: - UI Configuration

private extension LoadingIndicatorFooterView {
    func layoutUI() {
        addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
