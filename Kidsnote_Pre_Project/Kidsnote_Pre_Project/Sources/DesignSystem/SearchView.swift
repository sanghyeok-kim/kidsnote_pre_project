//
//  SearchView.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/05.
//

import UIKit

final class SearchView: ShadowView {
    
    private(set) var backButton: UIButton = {
        let button = UIButton()
        let image = ImageAsset.chevronLeft?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        return button
    }()
    
    private(set) var searchBookTextField = SearchBookTextField()
    
    private let separaterView = SeparatorView()
    
    override init() {
        super.init()
        backgroundColor = .systemBackground
        layoutUI()
    }
    
    private func layoutUI() {
        addSubview(backButton)
        addSubview(searchBookTextField)
        addSubview(separaterView)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: topAnchor, constant: 78).isActive = true
        backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        
        searchBookTextField.translatesAutoresizingMaskIntoConstraints = false
        searchBookTextField.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        searchBookTextField.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 24).isActive = true
        
        separaterView.translatesAutoresizingMaskIntoConstraints = false
        separaterView.topAnchor.constraint(equalTo: searchBookTextField.bottomAnchor, constant: 18).isActive = true
        separaterView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separaterView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
