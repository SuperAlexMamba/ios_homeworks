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
    
    var checkerService: CheckerServiceProtocol?
    
    init() {
        rootViewController = UINavigationController()
    }
    
    lazy var loginViewController: LoginViewController = {
        var vc = LoginViewController()
                
        checkerService = MyLoginFactory().makeLoginInspector()
        
        vc.registerUser = { [weak self] in
            self?.createUser()
        }
        
        vc.loginUser = { [weak self] in
            self?.loginUser()
        }
        
        return vc
    }()
    
    lazy var profileViewController: ProfileViewController = {
        var vc = ProfileViewController()
        
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([loginViewController], animated: false)
    }
    
    func createUser() {
        
        let delegate = checkerService
        
        guard let login = loginViewController.loginTextField.text else { return }
        guard let password = loginViewController.passwordTextField.text else { return }
        
        delegate?.signUp(with: login, and: password, loginVC: self.loginViewController, profileVC: self.profileViewController)
        
    }
    
    func loginUser() {
        
        let delegate = checkerService
        let profileModel = ProfileViewModel()
        let currentUser = profileModel.currentUser

        
        guard let login = loginViewController.loginTextField.text else { return }
        guard let password = loginViewController.passwordTextField.text else { return }
        
        delegate?.checkCredentials(login: login, password: password, loginVC: self.loginViewController, profileVC: self.profileViewController)
                
        profileViewController.profileHeader.profileName.text = "\(login)"
        profileViewController.profileHeader.profilePhoto.image = currentUser.user.image
        profileViewController.profileHeader.backgroundColor = .darkGray
        
    }
    
//    func goToProfile() {
//
//        let profileCoordinator = ProfileCoordinator()
//        let profileViewController = profileCoordinator.profileViewController
//        let profileModel = ProfileViewModel()
//        let testUser = profileModel.testUser
//        let currentUser = profileModel.currentUser
//        let loginDelegate = loginDelegate
//
//        guard let login = loginViewController.loginTextField.text else {return}
//        guard let password = loginViewController.passwordTextField.text else {return}
//
//#if DEBUG
//
//        if loginDelegate?.check(login: login, password: password) == true {
//
//            profileViewController.profileHeader.profilePhoto.image = currentUser.user.image
//            profileViewController.profileHeader.profileName.text = currentUser.user.login
//            profileViewController.profileHeader.profileStatus.text = currentUser.user.status
//            profileViewController.view.backgroundColor = .lightGray
//            rootViewController.pushViewController(profileViewController, animated: true)
//            print("Успешная авторизация ")
//        }
//        else{
//            loginViewController.errorLoginAlert()
//        }
//#else
//        if loginDelegate?.check(login: login, password: password) == true {
//            profileViewController.profileHeader.profilePhoto.image = testUser.user.image
//            profileViewController.profileHeader.profileName.text = testUser.user.login
//            profileViewController.profileHeader.profileStatus.text = testUser.user.status
//            profileViewController.view.backgroundColor = .lightGray
//            rootViewController.pushViewController(profileViewController, animated: true)
//            print("Успешная авторизация ")
//        }
//        else{
//            loginViewController.errorLoginAlert()
//        }
//#endif
//    }
}
