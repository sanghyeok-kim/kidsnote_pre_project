//
//  ColorAsset.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/07.
//

import UIKit

enum ColorAsset {
    enum BookTypeSegmentControl {
        static let selectedTitle = UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor(red: 25 / 255, green: 115 / 255, blue: 230 / 255, alpha: 1.0)
            default:
                return UIColor(red: 25 / 255, green: 115 / 255, blue: 230 / 255, alpha: 1.0)
            }
        }
    }
}
