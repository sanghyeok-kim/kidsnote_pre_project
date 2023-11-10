//
//  SearchHomeCoordinateAction.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/09.
//

import Foundation

enum SearchHomeCoordinateAction {
    case appDidStart
    case pushBookDetailViewController(BookEntity)
    case pushFullDescriptionViewController(title: String, description: String)
    case openURL(URL)
}
