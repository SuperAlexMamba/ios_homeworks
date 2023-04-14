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
    
    var appConfiguration: AppConfiguration?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        
        let appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
        
        let firstURL = AppConfiguration.firstURL(url: "https://swapi.dev/api/people/8")
        let secondURL = AppConfiguration.secondURL(url: "https://swapi.dev/api/starships/3")
        let thirdURL = AppConfiguration.thirdURL(url: "https://swapi.dev/api/planets/5")
        
        self.appCoordinator = appCoordinator
        
        NetworkService.request(for: secondURL)
        
        window.makeKeyAndVisible()
    }
        
}

