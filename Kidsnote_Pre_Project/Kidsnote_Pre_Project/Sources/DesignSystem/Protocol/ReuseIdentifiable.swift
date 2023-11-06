//
//  ReuseIdentifiable.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/06.
//

import UIKit

public protocol ReuseIdentifiable { }

extension ReuseIdentifiable {
    public static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReuseIdentifiable { }
extension UITableViewCell: ReuseIdentifiable { }
extension UICollectionReusableView: ReuseIdentifiable { }
extension UITableViewHeaderFooterView: ReuseIdentifiable { }
