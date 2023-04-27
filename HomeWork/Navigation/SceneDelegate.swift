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
        
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        
        let appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
                
        self.appCoordinator = appCoordinator
        
        window.makeKeyAndVisible()
    }
}

