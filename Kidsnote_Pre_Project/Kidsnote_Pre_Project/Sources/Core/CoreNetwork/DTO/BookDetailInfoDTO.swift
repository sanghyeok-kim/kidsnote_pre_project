//
//  BookDetailInfoDTO.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/10.
//

import Foundation

struct BookDescriptionDetailDTO: Decodable {
    let volumeInfo: VolumeInfo?
}

extension BookDescriptionDetailDTO {
    struct VolumeInfo: Decodable {
        let description: String?
    }
}
