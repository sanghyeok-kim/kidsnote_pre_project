//
//  BookSearchResultDTO.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import Foundation

struct BookSearchResultDTO: Decodable {
    let kind: String?
    let totalItems: Int?
    let items: [BookDTO]?
}

extension BookSearchResultDTO {
    struct BookDTO: Decodable {
        let kind: String?
        let id: String
        let etag: String?
        let volumeInfo: VolumeInfo?
        let saleInfo: SaleInfo?
        let accessInfo: AccessInfo?
    }
}

extension BookSearchResultDTO.BookDTO {
    struct VolumeInfo: Decodable {
        let title: String?
        let authors: [String]?
        let publishedDate, description: String?
        let industryIdentifiers: [IndustryIdentifier]?
        let pageCount: Int?
        let canonicalVolumeLink: String?
        let imageLinks: ImageLinks?
    }

    struct SaleInfo: Decodable {
        let isEbook: Bool?
        let buyLink: String?
    }

    struct AccessInfo: Decodable {
        let webReaderLink: String?
        let accessViewStatus: String?
    }
}

extension BookSearchResultDTO.BookDTO.VolumeInfo {
    struct ImageLinks: Decodable {
        let smallThumbnail, thumbnail: String?
    }
    
    struct IndustryIdentifier: Decodable {
        let type: String?
        let identifier: String?
    }
}
