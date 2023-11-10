//
//  BookEntityMapper.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/04.
//

import Foundation

struct BookEntityMapper: DataMapper {
    func transform(_ dto: BookSearchResultDTO) -> [BookEntity] {
        return dto.items?.map { dtoItem -> BookEntity in
            let isbn13Identifier = dtoItem.volumeInfo?.industryIdentifiers?.first { $0.type == "ISBN_13" }?.identifier
            let smallThumbnailURL = dtoItem.volumeInfo?.imageLinks?.smallThumbnail
            let thumbnailURL = dtoItem.volumeInfo?.imageLinks?.thumbnail
            let isEbook = dtoItem.saleInfo?.isEbook
            let buyLink = dtoItem.saleInfo?.buyLink
            let sampleURL = dtoItem.accessInfo?.webReaderLink
            return BookEntity(
                id: dtoItem.id,
                title: dtoItem.volumeInfo?.title ?? "",
                authors: dtoItem.volumeInfo?.authors?.joined(separator: ", ") ?? "",
                publisher: dtoItem.volumeInfo?.publisher ?? "",
                publishedDate: dtoItem.volumeInfo?.publishedDate ?? "",
                description: dtoItem.volumeInfo?.description ?? "",
                isbn13Identifier: isbn13Identifier ?? "",
                pageCount: dtoItem.volumeInfo?.pageCount ?? .zero,
                shareURL: URL(string: dtoItem.volumeInfo?.canonicalVolumeLink ?? ""),
                smallThumbnailURL: URL(string: smallThumbnailURL ?? ""),
                thumbnailURL: URL(string: thumbnailURL ?? ""),
                isEbook: isEbook ?? false,
                buyURL: URL(string: buyLink ?? ""),
                sampleURL: URL(string: sampleURL ?? "")
            )
        } ?? []
    }
}
