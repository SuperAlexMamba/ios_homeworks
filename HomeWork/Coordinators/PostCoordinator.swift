//
//  PostCoordinator.swift
//  Navigation
//
//  Created by Слава Орлов on 05.04.2023.
//

import UIKit

class PostCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    
    init() {
        self.rootViewController = UINavigationController()
    }
    
    lazy var postViewController: PostViewController = {
        let vc = PostViewController()
        vc.title = vc.titleString
        return vc
    }()
    
    func start() {

        rootViewController.setViewControllers([postViewController], animated: true)
    }
}
