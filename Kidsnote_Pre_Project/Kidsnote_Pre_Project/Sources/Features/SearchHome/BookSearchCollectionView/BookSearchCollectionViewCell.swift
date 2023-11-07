//
//  BookSearchCollectionViewCell.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/05.
//

import UIKit

import RxSwift

final class BookSearchCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.textColor = .systemGray
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let ebookLabel: UILabel = {
        let label = UILabel()
        label.text = "eBook"
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, authorLabel, ebookLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private let thumbnailImageView: ShadowImageView = {
        let imageView = ShadowImageView()
        imageView.layer.cornerRadius = 6
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    @Injected(AppDIContainer.shared) private var imageLoadService: ImageLoadService
    private var disposeBag = DisposeBag()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = nil
        titleLabel.text = nil
        authorLabel.text = nil
        ebookLabel.text = nil
        thumbnailImageView.image = nil
        disposeBag = DisposeBag()
    }
}

// MARK: - Supporting Methods

extension BookSearchCollectionViewCell {
    func configure(with book: BookEntity) {
        titleLabel.text = book.title
        authorLabel.text = book.authors
        ebookLabel.isHidden = !book.isEbook
        
        imageLoadService.fetchImage(from: book.thumbnailURL)
            .catchErrorReturnImage(invalidURLErrorImage: ImageAsset.emptyBookCover)
            .bind(to: thumbnailImageView.rx.resizedWidthImage)
            .disposed(by: disposeBag)
    }
}

// MARK: - UI Layout

private extension BookSearchCollectionViewCell {
    func layoutUI() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(labelStackView)
        
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3).isActive = true
        labelStackView.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 12).isActive = true
        labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24).isActive = true
        labelStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor).isActive = true
    }
}
