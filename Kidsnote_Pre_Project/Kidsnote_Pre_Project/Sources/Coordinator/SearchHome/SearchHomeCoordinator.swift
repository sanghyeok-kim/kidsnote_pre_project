//
//  SearchHomeCoordinator.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/09.
//

import Foundation

protocol SearchHomeCoordinator: Coordinator {
    func coordinate(by coordinateAction: SearchHomeCoordinateAction)
}
