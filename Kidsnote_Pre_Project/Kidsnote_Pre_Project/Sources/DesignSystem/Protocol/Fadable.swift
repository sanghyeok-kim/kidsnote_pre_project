//
//  Fadable.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/06.
//

import UIKit

protocol Fadable where Self: UIView { }

extension Fadable {
    func fadeIn(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.alpha = 1.0
        }, completion: { _ in
            completion?()
        })
    }
    
    func delayedFadeOut() {
        UIView.animate(withDuration: 0.5, delay: 2.5, options: .curveEaseIn, animations: { [weak self] in
            self?.alpha = .zero
        })
    }
}
