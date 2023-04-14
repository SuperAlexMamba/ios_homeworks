//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Слава Орлов on 05.04.2023.
//

import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    
    var window = UIWindow()
    
    var childCoordinators = [Coordinator]()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let mainCoordinator = MainCoordinator()
        mainCoordinator.start()
        self.childCoordinators = [mainCoordinator]
        self.window.rootViewController = mainCoordinator.rootViewController
    }
        
}
