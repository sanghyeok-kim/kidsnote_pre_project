//
//  BookDetailViewController.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/09.
//

import UIKit

import ReactorKit
import RxCocoa
import RxSwift

final class BookDetailViewController: BaseViewController, View {
    
    private let shareButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.up")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal),
            style: .plain,
            target: nil,
            action: nil
        )
        return barButtonItem
    }()
    
    private let scrollView = UIScrollView()
    private let scrollContentView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.numberOfLines = .zero
        return label
    }()
    
    private let authorsLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var titleAuthorInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            authorsLabel,
        ])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private let isEbookLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    private let eBookPageCountSeparatorLabel: DotSeparatorLabel = {
        let label = DotSeparatorLabel()
        label.textColor = .darkGray
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private let pageCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    private lazy var eBookPageCountInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            isEbookLabel,
            eBookPageCountSeparatorLabel,
            pageCountLabel,
        ])
        stackView.axis = .horizontal
        stackView.spacing = 3
        return stackView
    }()
    
    private lazy var bookDetailInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleAuthorInfoStackView,
            eBookPageCountInfoStackView,
        ])
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private let bookImageView: ShadowImageView = {
        let imageView = ShadowImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var bookMainInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            bookImageView,
            bookDetailInfoStackView,
        ])
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 20
        return stackView
    }()
    
    private let sampleBuyButtonTopSeparatorView = SeparatorView()
    
    private let sampleButton: UIButton = {
        let button = UIButton()
        button.setTitle(Literal.Text.readSample.appString, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle(Literal.Text.download.appString, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    private let gooplePlayReadableNoticeStackView = GooplePlayReadableNoticeStackView()
    
    private let sampleBuyButtonBottomSeparatorView = SeparatorView()
    
    private let notReviewedYetLabel: UILabel = {
        let label = UILabel()
        label.text = Literal.Text.notReviewedYet.appString
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.isHidden = true
        return label
    }()
    
    private lazy var sampleBuyButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            sampleButton,
            downloadButton,
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let ebookInfoDescriptionView = EbookInfoDescriptionView()
    
    
    private let publishInfoLabel: UILabel = {
        let label = UILabel()
        label.text = Literal.Text.publishDate.appString
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let pubilshDateLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .darkGray
        return label
    }()
    
    private let publishDatePublishDotSeparatorLabel: DotSeparatorLabel = {
        let label = DotSeparatorLabel()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.textColor = .darkGray
        return label
    }()
    
    private let publisherLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var publishDatePublisherStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            pubilshDateLabel,
            publishDatePublishDotSeparatorLabel,
            publisherLabel,
        ])
        stackView.axis = .horizontal
        stackView.spacing = 3
        return stackView
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private let ratingView = StarRatingView()
    
    private let toastLabel = ToastLabel()
    
    private let bookImageWidth: CGFloat = 110.0
    
    @Injected(AppDIContainer.shared) private var imageLoadService: ImageLoadService
    var disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Bind Reactor
    
    func bind(reactor: BookDetailReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    // MARK: - Configure UI
    
    override func configureUI() {
        super.configureUI()
        navigationItem.rightBarButtonItem = shareButton
    }
    
    // MARK: - Layout UI
    
    override func layoutUI() {
        super.layoutUI()
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(bookMainInfoStackView)
        scrollContentView.addSubview(sampleBuyButtonTopSeparatorView)
        scrollContentView.addSubview(sampleBuyButtonStackView)
        scrollContentView.addSubview(gooplePlayReadableNoticeStackView)
        scrollContentView.addSubview(sampleBuyButtonBottomSeparatorView)
        scrollContentView.addSubview(notReviewedYetLabel)
        scrollContentView.addSubview(ratingView)
        scrollContentView.addSubview(ebookInfoDescriptionView)
        scrollContentView.addSubview(publishInfoLabel)
        scrollContentView.addSubview(publishDatePublisherStackView)
        view.addSubview(loadingIndicator)
        view.addSubview(toastLabel)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        scrollContentView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        scrollContentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        scrollContentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor).isActive = true
        scrollContentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor).isActive = true
        scrollContentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
        scrollContentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
        scrollContentView.bottomAnchor.constraint(equalTo: publishDatePublisherStackView.bottomAnchor, constant: 36).isActive = true
        
        bookImageView.widthAnchor.constraint(equalToConstant: bookImageWidth).isActive = true
        
        bookMainInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        bookMainInfoStackView.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 20).isActive = true
        bookMainInfoStackView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 24).isActive = true
        bookMainInfoStackView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -24).isActive = true
        
        sampleBuyButtonTopSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        sampleBuyButtonTopSeparatorView.topAnchor.constraint(equalTo: bookMainInfoStackView.bottomAnchor, constant: 22).isActive = true
        sampleBuyButtonTopSeparatorView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
        sampleBuyButtonTopSeparatorView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        
        sampleBuyButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        sampleBuyButtonStackView.topAnchor.constraint(equalTo: sampleBuyButtonTopSeparatorView.bottomAnchor, constant: 18).isActive = true
        sampleBuyButtonStackView.leadingAnchor.constraint(equalTo: bookMainInfoStackView.leadingAnchor).isActive = true
        sampleBuyButtonStackView.trailingAnchor.constraint(equalTo: bookMainInfoStackView.trailingAnchor).isActive = true
        sampleBuyButtonStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        gooplePlayReadableNoticeStackView.translatesAutoresizingMaskIntoConstraints = false
        gooplePlayReadableNoticeStackView.topAnchor.constraint(equalTo: sampleBuyButtonStackView.bottomAnchor, constant: 16).isActive = true
        gooplePlayReadableNoticeStackView.leadingAnchor.constraint(equalTo: bookMainInfoStackView.leadingAnchor).isActive = true
        gooplePlayReadableNoticeStackView.trailingAnchor.constraint(equalTo: bookMainInfoStackView.trailingAnchor).isActive = true
        
        sampleBuyButtonBottomSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        sampleBuyButtonBottomSeparatorView.topAnchor.constraint(equalTo: gooplePlayReadableNoticeStackView.bottomAnchor, constant: 20).isActive = true
        sampleBuyButtonBottomSeparatorView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
        sampleBuyButtonBottomSeparatorView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.topAnchor.constraint(equalTo: sampleBuyButtonBottomSeparatorView.bottomAnchor, constant: 12).isActive = true
        ratingView.leadingAnchor.constraint(equalTo: bookMainInfoStackView.leadingAnchor).isActive = true
        ratingView.trailingAnchor.constraint(equalTo: bookMainInfoStackView.trailingAnchor).isActive = true
        
        notReviewedYetLabel.translatesAutoresizingMaskIntoConstraints = false
        notReviewedYetLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor).isActive = true
        notReviewedYetLabel.leadingAnchor.constraint(equalTo: bookMainInfoStackView.leadingAnchor).isActive = true
        notReviewedYetLabel.trailingAnchor.constraint(equalTo: bookMainInfoStackView.trailingAnchor).isActive = true
        
        ebookInfoDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        ebookInfoDescriptionView.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 22).isActive = true
        ebookInfoDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        ebookInfoDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        publishInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        publishInfoLabel.topAnchor.constraint(equalTo: ebookInfoDescriptionView.bottomAnchor, constant: 30).isActive = true
        publishInfoLabel.leadingAnchor.constraint(equalTo: bookMainInfoStackView.leadingAnchor).isActive = true
        
        publishDatePublisherStackView.translatesAutoresizingMaskIntoConstraints = false
        publishDatePublisherStackView.topAnchor.constraint(equalTo: publishInfoLabel.bottomAnchor, constant: 12).isActive = true
        publishDatePublisherStackView.leadingAnchor.constraint(equalTo: bookMainInfoStackView.leadingAnchor).isActive = true
        publishDatePublisherStackView.trailingAnchor.constraint(equalTo: bookMainInfoStackView.trailingAnchor).isActive = true
        
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        toastLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32).isActive = true
    }
}

// MARK: - Bind Reactor

private extension BookDetailViewController {
    func bindAction(reactor: BookDetailReactor) {
        
        rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        shareButton.rx.tap
            .map { Reactor.Action.shareButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        sampleButton.rx.tap
            .map { Reactor.Action.sampleButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        downloadButton.rx.tap
            .map { Reactor.Action.downloadButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        ebookInfoDescriptionView.rx.tap
            .map { Reactor.Action.descriptonViewDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
    
    func bindState(reactor: BookDetailReactor) {
        
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.authors }
            .distinctUntilChanged()
            .bind(to: authorsLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.publisher }
            .distinctUntilChanged()
            .bind(to: publisherLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.publisher }
            .distinctUntilChanged()
            .map { $0.isEmpty }
            .bind(to: publishDatePublishDotSeparatorLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.publishedDate }
            .distinctUntilChanged()
            .bind(to: pubilshDateLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.description }
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
            .bind(to: ebookInfoDescriptionView.rx.descriptionText)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.pageCount }
            .map { Literal.Text.page($0).appString }
            .distinctUntilChanged()
            .bind(to: pageCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.thumbnailURL }
            .distinctUntilChanged()
            .withUnretained(self)
            .flatMap { `self`, url in
                self.imageLoadService
                    .fetchImage(from: url)
                    .catchErrorReturnImage(invalidURLErrorImage: ImageAsset.emptyBookCover)
                    .map { $0?.resizedAspect(width: self.bookImageWidth) }
            }
            .bind(to: bookImageView.rx.image)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isEbook }
            .filter { $0 }
            .map { _ in Literal.Text.eBook.appString }
            .distinctUntilChanged()
            .bind(to: isEbookLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.compactMap { $0.reviewRank }
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .bind {
                print($0)
                self.ratingView.rating = $0
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isNotReviewedYet }
            .distinctUntilChanged()
            .bind(to: ratingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isNotReviewedYet }
            .distinctUntilChanged()
            .map { !$0 }
            .bind(to: notReviewedYetLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isEmptyDescription }
            .distinctUntilChanged()
            .filter { $0 }
            .map { _ in }
            .observe(on: MainScheduler.asyncInstance)
            .bind(onNext: ebookInfoDescriptionView.setEmptyDescription)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoadingIndicatorAnimating }
            .distinctUntilChanged()
            .bind(to: loadingIndicator.rx.isAnimating, scrollContentView.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$toastMessage)
            .compactMap { $0 }
            .observe(on: MainScheduler.asyncInstance)
            .bind(onNext: toastLabel.show(message:))
            .disposed(by: disposeBag)
    }
}
