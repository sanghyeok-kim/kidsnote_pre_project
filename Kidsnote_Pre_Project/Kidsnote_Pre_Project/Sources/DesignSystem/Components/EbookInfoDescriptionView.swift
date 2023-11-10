//
//  EbookInfoDescriptionView.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/10.
//

import UIKit

final class EbookInfoDescriptionView: TapInteractiveView {

    private let infoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Literal.Text.eBookInfo.appString
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()

    private(set) var expandRightImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private(set) var descriptionPreviewLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    func setEmptyDescription() {
        let paragraphStyle = NSMutableParagraphStyle()
        let attributedString = NSMutableAttributedString(
            string: Literal.Text.noDescriptionYet.appString,
            attributes: [
                .font: UIFont.systemFont(ofSize: 15),
                .foregroundColor: UIColor.darkGray
            ]
        )
        isEnabled = false
        expandRightImageView.isHidden = true
        descriptionPreviewLabel.attributedText = attributedString
    }
}

// MARK: - Layout UI

private extension EbookInfoDescriptionView {
    func layoutUI() {
        addSubview(infoTitleLabel)
        addSubview(expandRightImageView)
        addSubview(descriptionPreviewLabel)
        
        infoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        infoTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        infoTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        infoTitleLabel.trailingAnchor.constraint(equalTo: expandRightImageView.leadingAnchor, constant: -32).isActive = true
        
        expandRightImageView.translatesAutoresizingMaskIntoConstraints = false
        expandRightImageView.topAnchor.constraint(equalTo: infoTitleLabel.topAnchor).isActive = true
        expandRightImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        expandRightImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        expandRightImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        descriptionPreviewLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionPreviewLabel.topAnchor.constraint(equalTo: infoTitleLabel.bottomAnchor, constant: 12).isActive = true
        descriptionPreviewLabel.leadingAnchor.constraint(equalTo: infoTitleLabel.leadingAnchor).isActive = true
        descriptionPreviewLabel.trailingAnchor.constraint(equalTo: expandRightImageView.trailingAnchor).isActive = true
        descriptionPreviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
}
