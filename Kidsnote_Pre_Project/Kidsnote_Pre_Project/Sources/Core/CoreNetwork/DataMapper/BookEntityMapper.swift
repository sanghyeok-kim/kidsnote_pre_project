//
//  BookEntityMapper.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/04.
//

import Foundation

struct BookEntityMapper: DataMapper {
    func transform(_ dto: BookSearchResultDTO) throws -> [BookEntity] {
        return dto.items.map { dtoItem -> BookEntity in
            let isbn13Identifier = dtoItem.volumeInfo?.industryIdentifiers?.first { $0.type == "ISBN_13" }?.identifier
            let smallThumbnailURL = dtoItem.volumeInfo?.imageLinks?.smallThumbnail
            let thumbnailURL = dtoItem.volumeInfo?.imageLinks?.thumbnail
            let isEbook = dtoItem.saleInfo?.isEbook
            let buyLink = dtoItem.saleInfo?.buyLink
            let sampleURL = dtoItem.accessInfo?.webReaderLink
            return BookEntity(
                id: dtoItem.id,
                title: dtoItem.volumeInfo?.title ?? "",
                authors: dtoItem.volumeInfo?.authors ?? [],
                publishedDate: dtoItem.volumeInfo?.publishedDate,
                description: dtoItem.volumeInfo?.description,
                isbn13Identifier: isbn13Identifier,
                pageCount: dtoItem.volumeInfo?.pageCount,
                shareURL: dtoItem.volumeInfo?.canonicalVolumeLink,
                smallThumbnailURL: smallThumbnailURL,
                thumbnailURL: thumbnailURL,
                isEbook: isEbook,
                buyLink: buyLink,
                sampleURL: sampleURL
            )
        }
    }
}
