//
//  Reactive+EbookInfoDescriptionView.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/10.
//

import RxSwift
import RxCocoa

extension Reactive where Base: EbookInfoDescriptionView {
    var descriptionText: ControlProperty<String> {
        return base.rx.controlProperty(
            editingEvents: [.allEditingEvents, .valueChanged],
            getter: { ebookInfoDescriptionView in
                let attributedText = ebookInfoDescriptionView.descriptionPreviewLabel.attributedText?.string
                return attributedText ?? ""
            },
            setter: { ebookInfoDescriptionView, newText in
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 10
                paragraphStyle.lineBreakMode = .byTruncatingTail
                let attributedString = NSMutableAttributedString(
                    string: newText,
                    attributes: [
                        .paragraphStyle: paragraphStyle,
                        .font: UIFont.systemFont(ofSize: 15),
                        .foregroundColor: UIColor.darkGray
                    ]
                )
                ebookInfoDescriptionView.descriptionPreviewLabel.numberOfLines = 4
                ebookInfoDescriptionView.descriptionPreviewLabel.attributedText = attributedString
            }
        )
    }
}
