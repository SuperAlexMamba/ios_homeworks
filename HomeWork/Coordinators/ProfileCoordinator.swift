//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Слава Орлов on 06.04.2023.
//

import UIKit

class ProfileCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    
    init() {
        self.rootViewController = UINavigationController()
    }
    
    lazy var profileViewController = {
        let vc = ProfileViewController()
        
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([profileViewController], animated: true)
    }
}
