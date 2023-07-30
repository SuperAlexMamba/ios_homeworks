//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Слава Орлов on 05.04.2023.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    var rootViewController = UITabBarController()
    
    init() {
        self.rootViewController = UITabBarController()
        self.rootViewController.tabBar.isTranslucent = true
        self.rootViewController.tabBar.backgroundColor = .lightGray
    }
    
    func start() {
        
        let loginCoordinator = LoginCoordinator()
        loginCoordinator.start()
        self.childCoordinators.append(loginCoordinator)
        let loginViewController = loginCoordinator.rootViewController
        setupBar(vc: loginViewController,
                 title: NSLocalizedString("profile_key", comment: ""),
                 image: "bell",
                 selectedImage: "bell.fill")
        
        let feedCoordinator = FeedCoordinator()
        feedCoordinator.start()
        self.childCoordinators.append(feedCoordinator)
        let feedViewController = feedCoordinator.rootViewController
        setupBar(vc: feedViewController,
                 title: NSLocalizedString("feed_title_key", comment: ""),
                 image: "paperplane",
                 selectedImage: "paperplane.fill")
        
        let likedPostsCoordinator = LikedPostsCoordinator()
        likedPostsCoordinator.start()
        self.childCoordinators.append(likedPostsCoordinator)
        let likedPostsViewController = likedPostsCoordinator.rootViewController
        setupBar(vc: likedPostsViewController,
                 title: NSLocalizedString("liked_posts_title_key", comment: ""),
                 image: "hand.thumbsup",
                 selectedImage: "hand.thumbsup.fill")
        
        let mapCoordinator = MapCoordinator()
        mapCoordinator.start()
        self.childCoordinators.append(mapCoordinator)
        let mapViewController = mapCoordinator.rootController
        setupBar(vc: mapViewController,
                 title: NSLocalizedString("map_key", comment: ""),
                 image: "globe.europe.africa",
                 selectedImage: "globe.europe.africa.fill")
        
        self.rootViewController.viewControllers = [loginCoordinator.rootViewController,
                                                   feedCoordinator.rootViewController,
                                                   likedPostsCoordinator.rootViewController,
                                                   mapCoordinator.rootController]
        
        rootViewController.delegate = likedPostsCoordinator.likedPostsViewController as any UITabBarControllerDelegate
        
    }
        
    func setupBar(vc: UIViewController, title: String , image: String , selectedImage: String) {
        
        let defaultImage = UIImage(systemName: image)
        let selectedImage = UIImage(systemName: selectedImage)
        let tabBarItem = UITabBarItem(title: title, image: defaultImage, selectedImage: selectedImage)
        
        vc.tabBarItem = tabBarItem
        
    }
    
}
