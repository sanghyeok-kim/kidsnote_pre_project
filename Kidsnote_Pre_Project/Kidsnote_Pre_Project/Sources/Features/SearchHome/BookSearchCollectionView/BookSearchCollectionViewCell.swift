//
//  BookSearchCollectionViewCell.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/05.
//

import UIKit

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
    }
}

// MARK: - Supporting Methods

extension BookSearchCollectionViewCell {
    
    // TODO: 이미지 로더 타입을 별도로 구현하여 코드 개선
    func configure(with book: BookEntity) {
        titleLabel.text = book.title
        authorLabel.text = book.authors
        ebookLabel.isHidden = !book.isEbook
        
        guard let imageURL = book.smallThumbnailURL else {
            layoutIfNeeded()
            let emptyCoverImage =  UIImage(named: "EmptyBookCover")
            thumbnailImageView.image = emptyCoverImage?.resizeAspectFit(width: self.thumbnailImageView.frame.width)
            return
        }
        
        if let url = URL(string: imageURL) {
            downloadImage(from: url) { downloadImage in
                self.thumbnailImageView.image = downloadImage?.resizeAspectFit(width: self.thumbnailImageView.frame.width)
            }
        }
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil, let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(image)
                }
            }.resume()
        }
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
