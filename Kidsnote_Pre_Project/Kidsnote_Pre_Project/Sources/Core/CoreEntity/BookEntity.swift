//
//  BookEntity.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/04.
//

import Foundation

struct BookEntity {
    let id: String
    let title: String
    let authors: String
    let publishedDate: String
    let description: String
    let isbn13Identifier: String
    let pageCount: Int
    let shareURL: String?
    let smallThumbnailURL: String?
    let thumbnailURL: String?
    let isEbook: Bool
    let buyLinkURL: String?
    let sampleURL: String?
}
