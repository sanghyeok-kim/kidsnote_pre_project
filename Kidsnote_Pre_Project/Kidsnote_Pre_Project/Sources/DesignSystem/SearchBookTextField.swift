//
//  SearchBookTextField.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/04.
//

import UIKit

final class SearchBookTextField: UITextField {
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        let textAttributedString = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ]
        attributedPlaceholder = NSAttributedString(
            string: Literal.Text.sarchInPlayBook,
            attributes: textAttributedString
        )
    }
}
