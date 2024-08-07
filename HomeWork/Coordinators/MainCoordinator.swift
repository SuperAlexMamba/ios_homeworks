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
        self.rootViewController.tabBar.isTranslucent = true
        self.rootViewController.tabBar.backgroundColor = .lightGray
    }
    
    func start() {
        
        let profileCoordinator = ProfileCoordinator()
        profileCoordinator.start()
        self.childCoordinators.append(profileCoordinator)
        let profileViewController = profileCoordinator.rootViewController
        setupBar(vc: profileViewController,
                 title: "profile_key".localized,
                 image: "person.crop.circle",
                 selectedImage: "person.crop.circle.fill")
        
        let feedCoordinator = FeedCoordinator()
        feedCoordinator.start()
        self.childCoordinators.append(feedCoordinator)
        let feedViewController = feedCoordinator.rootViewController
        setupBar(vc: feedViewController,
                 title: "feed_title_key".localized,
                 image: "newspaper",
                 selectedImage: "newspaper.fill")
        
        let likedPostsCoordinator = LikedPostsCoordinator()
        likedPostsCoordinator.start()
        self.childCoordinators.append(likedPostsCoordinator)
        let likedPostsViewController = likedPostsCoordinator.rootViewController
        setupBar(vc: likedPostsViewController,
                 title: "liked_posts_title_key".localized,
                 image: "hand.thumbsup",
                 selectedImage: "hand.thumbsup.fill")
        
        let mapCoordinator = MapCoordinator()
        mapCoordinator.start()
        self.childCoordinators.append(mapCoordinator)
        let mapViewController = mapCoordinator.rootController
        setupBar(vc: mapViewController,
                 title: "map_key".localized,
                 image: "globe.europe.africa",
                 selectedImage: "globe.europe.africa.fill")
        
        self.rootViewController.viewControllers = [profileCoordinator.rootViewController,
                                                   feedCoordinator.rootViewController,
                                                   likedPostsCoordinator.rootViewController,
                                                   /*mapCoordinator.rootController*/]
        
        rootViewController.delegate = likedPostsCoordinator.likedPostsViewController as any UITabBarControllerDelegate
        
    }
        
    func setupBar(vc: UIViewController, title: String , image: String , selectedImage: String) {
        
        let defaultImage = UIImage(systemName: image)
        let selectedImage = UIImage(systemName: selectedImage)
        let tabBarItem = UITabBarItem(title: title, image: defaultImage, selectedImage: selectedImage)
        
        vc.tabBarItem = tabBarItem
        
    }
    
}
