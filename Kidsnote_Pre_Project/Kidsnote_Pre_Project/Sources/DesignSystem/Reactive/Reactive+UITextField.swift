//
//  Reactive+UITextField.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/05.
//

import RxSwift
import RxCocoa

// MARK: - textChanged

extension Reactive where Base: UITextField {
    var textChanged: Observable<String> {
        return controlEvent(.editingChanged)
            .map { [weak base] in
                base?.text ?? ""
            }
    }
}

// MARK: - shouldBecomeFirstResponder

extension Reactive where Base: UITextField {
    var shouldBecomeFirstResponder: Binder<Bool> {
        return Binder(self.base) { textField, shouldBecomeFirstResponder in
            if shouldBecomeFirstResponder {
                textField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        }
    }
}

