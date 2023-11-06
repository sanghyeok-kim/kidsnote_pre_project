//
//  ToastLabel.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/06.
//

import UIKit

public final class ToastLabel: RoundedPaddingLabel {
    public override init(padding: Padding = .medium) {
        super.init(padding: padding)
        configureUI()
    }
    
    public func show(message: String) {
        text = message
        sizeToFit()
        fadeIn(completion: delayedFadeOut)
    }
    
    public func show(message: NSMutableAttributedString) {
        attributedText = message
        sizeToFit()
        fadeIn(completion: delayedFadeOut)
    }
    
    public func show(message: NSMutableAttributedString, backgroundColor: UIColor? = nil) {
        self.backgroundColor = backgroundColor
        show(message: message)
    }
}

// MARK: - UI Configuration

private extension ToastLabel {
    func configureUI() {
        alpha = .zero
        font = UIFont.systemFont(ofSize: 15)
        textAlignment = .center
        textColor = UIColor.white
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        numberOfLines = .zero
        lineBreakMode = .byWordWrapping
    }
}

// MARK: - Supporting Methods

private extension ToastLabel {
    func fadeIn(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.alpha = 1.0
        }, completion: { _ in
            completion()
        })
    }
    
    func delayedFadeOut() {
        UIView.animate(withDuration: 0.5, delay: 2.5, options: .curveEaseIn, animations: { [weak self] in
            self?.alpha = .zero
        })
    }
}
