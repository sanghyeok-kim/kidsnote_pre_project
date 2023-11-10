//
//  BookDetailInfoEntityMapper.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/10.
//

import Foundation

struct BookDetailInfoEntityMapper: DataMapper {
    func transform(_ dto: BookDescriptionDetailDTO) throws -> BookDetailInfoEntity {
        let dtoHTMLString = dto.volumeInfo?.description
        guard let description = dtoHTMLString?.convertHTMLToString() else {
            throw NetworkError.dataMappingError
        }
        
        return BookDetailInfoEntity(description: description)
    }
}

extension String {
    func convertHTMLToString() -> String? {
        let htmlString = self
        guard let data = htmlString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        let convertedString = try? NSAttributedString(
            data: data,
            options: options, documentAttributes: nil
        ).string

        return convertedString
    }
}

