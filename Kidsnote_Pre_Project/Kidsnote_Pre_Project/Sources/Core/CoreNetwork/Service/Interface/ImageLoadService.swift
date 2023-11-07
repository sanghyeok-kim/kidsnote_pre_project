//
//  ImageLoadService.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/07.
//

import Foundation

import RxSwift

protocol ImageLoadService {
    func fetchImage(from url: URL?) -> Observable<UIImage?>
}
