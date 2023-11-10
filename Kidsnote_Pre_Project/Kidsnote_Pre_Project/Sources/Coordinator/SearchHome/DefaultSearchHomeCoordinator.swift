//
//  DefaultSearchHomeCoordinator.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/09.
//

import UIKit

final class DefaultSearchHomeCoordinator: SearchHomeCoordinator {
    
    var childCoordinatorMap: [CoordinatorType: Coordinator] = [:]
    var navigationController: UINavigationController
    let type: CoordinatorType = .searchHome
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        coordinate(by: .appDidStart)
    }
    
    func coordinate(by coordinateAction: SearchHomeCoordinateAction) {
        switch coordinateAction {
        case .appDidStart:
            pushSearchHomeViewController()
        case .pushBookDetailViewController(let bookEntity):
            pushBookDetailViewController(bookEntity: bookEntity)
        case .openURL(let url):
            openURL(url)
        case .openActivityViewController(let items):
            openActivityViewController(items: items)
        }
    }
    
    deinit {
        Logger.logDeallocation(object: self)
    }
}

// MARK: - Coordinating Methods

private extension DefaultSearchHomeCoordinator {
    func pushSearchHomeViewController() {
        
    }
    
    func pushBookDetailViewController(bookEntity: BookEntity) {
        
    }
    
    func openURL(_ url: URL) {
        UIApplication.shared.open(url)
    }
    
    func openActivityViewController(items: [Any]) {
        
    }
}
