//
//  Coordinator.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/09.
//

import UIKit

public protocol Coordinator: AnyObject {
    var childCoordinatorMap: [CoordinatorType: Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var `type`: CoordinatorType { get }
    
    func start()
}

public extension Coordinator {
    func add(childCoordinator: Coordinator) {
        childCoordinatorMap[childCoordinator.type] = childCoordinator
    }
    
    func remove(childCoordinator type: CoordinatorType) {
        childCoordinatorMap.removeValue(forKey: type)
    }
}
