//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Слава Орлов on 05.04.2023.
//

import UIKit

class FeedCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    
    init() {
        rootViewController = UINavigationController()
    }
    
    lazy var feedViewController: FeedViewController = {
        let vc = FeedViewController()
        
        vc.showPost = { [weak self] in
            self?.goToPost()
        }
        
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([feedViewController], animated: false)
    }
    
    func goToPost() {
        let postViewController = PostViewController()
        rootViewController.pushViewController(postViewController, animated: true)
    }
}
