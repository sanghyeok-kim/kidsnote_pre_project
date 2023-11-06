//
//  Padding.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/06.
//

import UIKit.UIGeometry

public enum Padding {
    case custom(UIEdgeInsets)
    case small
    case medium
    case large
    
    public var insets: UIEdgeInsets {
        switch self {
        case .small:
            return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        case .medium:
            return UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        case .large:
            return UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
        case .custom(let edgeInsets):
            return edgeInsets
        }
    }
}
