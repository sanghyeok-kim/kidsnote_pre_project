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
        case .pushFullDescriptionViewController(let title, let description):
            pushFullDescriptionViewController(title: title, description: description)
        case .openURL(let url):
            openURL(url)
        }
    }
    
    deinit {
        Logger.logDeallocation(object: self)
    }
}

// MARK: - Coordinating Methods

private extension DefaultSearchHomeCoordinator {
    func pushSearchHomeViewController() {
        let searchHomeViewController = SearchHomeViewController()
        let searchHomeReactor = SearchHomeReactor(coordinator: self)
        searchHomeViewController.reactor = searchHomeReactor
        navigationController.pushViewController(searchHomeViewController, animated: false)
    }
    
    func pushBookDetailViewController(bookEntity: BookEntity) {
        let bookDetailViewController = BookDetailViewController()
        let bookDetailReactor = BookDetailReactor(coordinator: self, bookEntity: bookEntity)
        bookDetailViewController.reactor = bookDetailReactor
        navigationController.pushViewController(bookDetailViewController, animated: true)
    }
    
    func pushFullDescriptionViewController(title: String, description: String) {
        let bookDetailViewController = FullDescriptionViewController(title: title, description: description)
        navigationController.pushViewController(bookDetailViewController, animated: true)
    }
    
    func openURL(_ url: URL) {
        UIApplication.shared.open(url)
    }
}
