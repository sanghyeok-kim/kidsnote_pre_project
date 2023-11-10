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
    
    func openURL(_ url: URL) {
        UIApplication.shared.open(url)
    }
    
    /// ActivityController가 열리는 기능까지만 구현하기 위함.
    /// 실제 공유의 목적은 아니므로, 몇 가지  Activity Type을 제외하였음.
    func openActivityViewController(items: [Any]) {
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [
            .message, // 시뮬레이터에서 문자 앱이 열리지 않으므로 제외함
            .copyToPasteboard // 클립보드 권한을 받지 않을 것이므로 제외함
        ]
        navigationController.present(activityViewController, animated: true, completion: nil)
    }
}
