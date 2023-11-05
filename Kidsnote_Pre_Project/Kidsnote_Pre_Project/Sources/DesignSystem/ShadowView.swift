//
//  ShadowView.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/04.
//

import UIKit

class ShadowView: UIView {
    
    init() {
        super.init(frame: .zero)
        configureUI()
        configureShadow()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    private func configureUI() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
    }
    
    private func configureShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.35
        layer.shadowRadius = 1
        layer.masksToBounds = false
    }
}
