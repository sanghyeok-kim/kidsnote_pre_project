//
//  StarView.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/10.
//

import UIKit

final class StarView: UIView {
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    private var starImageViews: [UIImageView] = []
    
    private let maxRating = 5
    private let starSize: CGFloat = 22
    private let interStarSpacing: CGFloat = 5.0
    
    var rating: Double = 0 {
        didSet {
            updateStarRatings()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutUI()
    }
    
    private func updateStarRatings() {
        for (index, imageView) in starImageViews.enumerated() {
            if rating >= Double(index) + 1 {
                imageView.image = ImageAsset.starFill?
                    .withTintColor(.darkGray, renderingMode: .alwaysOriginal)
            } else if rating >= Double(index) + 0.5 {
                imageView.image = ImageAsset.starLeadinghalfFilled?
                    .withTintColor(.darkGray, renderingMode: .alwaysOriginal)
            } else {
                imageView.image = ImageAsset.star?
                    .withTintColor(.darkGray, renderingMode: .alwaysOriginal)
            }
        }
    }
}

// MARK: - Layout UI

private extension StarView {
    func layoutUI() {
        addSubview(ratingLabel)
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        ratingLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        for _ in 0..<maxRating {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            starImageViews.append(imageView)
            addSubview(imageView)
        }
        layoutStars()
    }
    
    func layoutStars() {
        for (index, imageView) in starImageViews.enumerated() {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(index) * (starSize + interStarSpacing)).isActive = true
            imageView.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: starSize).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: starSize).isActive = true
        }
    }
}
