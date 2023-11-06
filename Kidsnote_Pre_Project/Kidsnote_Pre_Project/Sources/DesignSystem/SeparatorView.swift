//
//  SeparatorView.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/04.
//

import UIKit

public final class SeparatorView: UIView {
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: .zero, height: 1.0)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .systemGray4
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
