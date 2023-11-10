//
//  StarRatingView.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/10.
//

import UIKit

final class StarRatingView: UIView {
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    private let ratingDataSourceLabel: UILabel = {
        let label = UILabel()
        label.text = "(평점 제공: 알라딘)"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .darkGray
        return label
    }()
    
    private let ratingView: StarView = {
        let view = StarView()
        return view
    }()
    
    var rating: Double = 0 {
        didSet {
            ratingLabel.text = String(format: "%.1f", rating)
            ratingView.rating = rating
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(ratingLabel)
        addSubview(ratingView)
        addSubview(ratingDataSourceLabel)
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 8).isActive = true
        ratingView.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor).isActive = true
        ratingView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        ratingView.heightAnchor.constraint(equalTo: ratingLabel.heightAnchor).isActive = true
        
        ratingDataSourceLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingDataSourceLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 4).isActive  = true
        ratingDataSourceLabel.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor).isActive = true
        ratingDataSourceLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
