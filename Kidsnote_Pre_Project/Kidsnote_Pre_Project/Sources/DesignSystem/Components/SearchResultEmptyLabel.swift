//
//  SearchResultEmptyLabel.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/06.
//

import UIKit

final class SearchResultEmptyLabel: UILabel, Fadable {
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setVisibility(shouldHide: Bool) {
        isHidden = shouldHide
        if shouldHide {
            alpha = .zero
        } else {
            fadeIn()
        }
    }
    
    private func configureUI() {
        text = Literal.Text.searchResultEmpty.appString
        font = .systemFont(ofSize: 16, weight: .medium)
        alpha = .zero
    }
}
