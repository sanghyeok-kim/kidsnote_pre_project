//
//  TapInteractiveView.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/10.
//

import UIKit

class TapInteractiveView: UIControl {
    
    override var isHighlighted: Bool {
        didSet {
            animateBackground(isHighlighted: isHighlighted)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInteraction()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInteraction()
    }

    private func setupInteraction() {
        addTarget(self, action: #selector(handleTouchDown), for: .touchDown)
        addTarget(self, action: #selector(handleTouchUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(handleTouchDragExit), for: .touchDragExit)
    }

    @objc private func handleTouchDown() {
        isHighlighted = true
    }

    @objc private func handleTouchUpInside() {
        isHighlighted = false
    }

    @objc private func handleTouchDragExit() {
        isHighlighted = false
    }
    
    private func animateBackground(isHighlighted: Bool) {
        let highlightedColor = UIColor(red: 227 / 255, green: 225 / 255, blue: 228 / 255, alpha: 1.0)
        let backgroundColor: UIColor = isHighlighted ? highlightedColor : .systemBackground
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = backgroundColor
        }
    }
}
