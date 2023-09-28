//
//  LikedPostsCoordinator.swift
//  Navigation
//
//  Created by Слава Орлов on 23.05.2023.
//

import UIKit

class LikedPostsCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    
    init() {
        self.rootViewController = UINavigationController()
    }
    
    lazy var likedPostsViewController = {
        let vc = LikedPostsViewController()
        
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([likedPostsViewController], animated: true)
    }
    
}
