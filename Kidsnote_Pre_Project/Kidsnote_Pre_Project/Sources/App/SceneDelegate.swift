//
//  SceneDelegate.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        AppDIContainer.shared.registerDependencies()
        
        let searchHomeViewController = SearchHomeViewController()
        let searchHomeReactor = SearchHomeReactor()
        searchHomeViewController.reactor = searchHomeReactor
        
        let rootNavigationViewController = UINavigationController(rootViewController: searchHomeViewController)
        window?.rootViewController = rootNavigationViewController
        window?.makeKeyAndVisible()
    }
}
