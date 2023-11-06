//
//  RoundedPaddingLabel.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/06.
//

import UIKit

public class RoundedPaddingLabel: PaddingLabel {
    public override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        layer.cornerRadius = min(frame.width, frame.height) / 2
    }
}
