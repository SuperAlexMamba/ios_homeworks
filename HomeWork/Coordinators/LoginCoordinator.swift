//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Слава Орлов on 05.04.2023.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    
    var loginDelegate: LoginViewControllerDelegate?
    
    init() {
        rootViewController = UINavigationController()
    }
    
    lazy var loginViewController: LoginViewController = {
        var vc = LoginViewController()
                
        loginDelegate = MyLoginFactory().makeLoginInspector()
        
        vc.goToProfile = { [weak self] in
            self?.goToProfile()
        }
        
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([loginViewController], animated: false)
    }
    
    func goToProfile() {
        
        let profileCoordinator = ProfileCoordinator()
        let profileViewController = profileCoordinator.profileViewController
        let profileModel = ProfileViewModel()
        let testUser = profileModel.testUser
        let currentUser = profileModel.currentUser
        let loginDelegate = loginDelegate
        
        guard let login = loginViewController.loginTextField.text else {return}
        guard let password = loginViewController.passwordTextField.text else {return}
        
#if DEBUG
        
        if loginDelegate?.check(login: login, password: password) == true {
            
            profileViewController.profileHeader.profilePhoto.image = currentUser.user.image
            profileViewController.profileHeader.profileName.text = currentUser.user.login
            profileViewController.profileHeader.profileStatus.text = currentUser.user.status
            profileViewController.view.backgroundColor = .lightGray
            rootViewController.pushViewController(profileViewController, animated: true)
            print("Успешная авторизация ")
        }
        else{
            loginViewController.errorLoginAlert()
        }
#else
        if loginDelegate?.check(login: login, password: password) == true {
            profileViewController.profileHeader.profilePhoto.image = testUser.user.image
            profileViewController.profileHeader.profileName.text = testUser.user.login
            profileViewController.profileHeader.profileStatus.text = testUser.user.status
            profileViewController.view.backgroundColor = .lightGray
            rootViewController.pushViewController(profileViewController, animated: true)
            print("Успешная авторизация ")
        }
        else{
            loginViewController.errorLoginAlert()
        }
#endif
    }
}
