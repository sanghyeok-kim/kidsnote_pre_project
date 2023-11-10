//
//  BookSearchBar.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/04.
//

import UIKit

final class BookSearchBar: ShadowView {
    
    private(set) var tapButton = UIButton()
    
    private let searchIconImageView: UIImageView = {
        let imageView = UIImageView()
        let image = ImageAsset.magnifyingglass?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let searchTextField = SearchBookTextField()
    
    override init() {
        super.init()
        layoutUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 55)
    }
    
    private func layoutUI() {
        defer {
            bringSubviewToFront(tapButton)
        }
        
        addSubview(tapButton)
        addSubview(searchIconImageView)
        addSubview(searchTextField)
        
        tapButton.translatesAutoresizingMaskIntoConstraints = false
        tapButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tapButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tapButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tapButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        searchIconImageView.translatesAutoresizingMaskIntoConstraints = false
        searchIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        searchIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        searchIconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        searchIconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.leadingAnchor.constraint(equalTo: searchIconImageView.trailingAnchor, constant: 16).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        searchTextField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
