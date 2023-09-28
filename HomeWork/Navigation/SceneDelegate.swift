//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Слава Орлов on 19.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var appCoordinator: AppCoordinator?
    
    var loginCoordinator: LoginCoordinator?
        
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        
        self.window = window
                
        let loginCoordinator = LoginCoordinator()
        
        self.loginCoordinator = loginCoordinator
        
        self.loginCoordinator?.start()
        
        self.loginCoordinator?.delegate = self
        
        window.rootViewController = loginCoordinator.rootViewController
        
        window.makeKeyAndVisible()
    }
}

extension SceneDelegate: LoginCoordinatorDelegate {
    
    func didCompleteLogin(coordinator: LoginCoordinator) {
        
        let mainCoordinator = MainCoordinator()
        
        mainCoordinator.start()
        
        window?.rootViewController = mainCoordinator.rootViewController
        
    }
    
}
