//
//  DotSeparatorLabel.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/10.
//

import UIKit

final class DotSeparatorLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure UI

private extension DotSeparatorLabel {
    func configureUI() {
        font = .systemFont(ofSize: 15, weight: .light)
        text = Literal.Text.dot.appString
    }
}
