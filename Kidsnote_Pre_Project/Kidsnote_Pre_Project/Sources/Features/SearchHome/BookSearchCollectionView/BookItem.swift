//
//  BookItem.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/06.
//

import Foundation

struct BookItem {
    let identifier: UUID = UUID()
    let bookEntity: BookEntity
}

extension BookItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: BookItem, rhs: BookItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
