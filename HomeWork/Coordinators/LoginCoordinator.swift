//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Слава Орлов on 05.04.2023.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    
    init() {
        rootViewController = UINavigationController()
    }
    
    lazy var loginViewController: LoginViewController = {
        var vc = LoginViewController()
        
        vc.loginDelegate = MyLoginFactory().makeLoginInspector()
        
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([loginViewController], animated: false)
    }
}
