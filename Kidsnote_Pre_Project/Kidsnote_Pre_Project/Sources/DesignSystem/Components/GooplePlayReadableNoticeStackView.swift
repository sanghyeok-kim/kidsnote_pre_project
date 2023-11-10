//
//  GooplePlayReadableNoticeStackView.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/10.
//

import UIKit

final class GooplePlayReadableNoticeStackView: UIView {
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "info.circle")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
        return imageView
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = Literal.Text.readbleInGooglePlay.appString
        label.font = UIFont.systemFont(ofSize: 12.5)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            iconImageView,
            infoLabel,
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 12
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout UI

private extension GooplePlayReadableNoticeStackView {
    func layoutUI() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        iconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}

