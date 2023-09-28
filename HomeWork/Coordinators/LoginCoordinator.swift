//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Слава Орлов on 05.04.2023.
//

import UIKit

protocol LoginCoordinatorDelegate: AnyObject {
    func didCompleteLogin(coordinator: LoginCoordinator)
}

class LoginCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    
    var loginDelegate: LoginViewControllerDelegate?
    
    var checkerService: CheckerServiceProtocol?
    
    weak var delegate: LoginCoordinatorDelegate?
    
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
        
        let profileModel = ProfileViewModel()
        let currentUser = profileModel.currentUser

        guard let login = loginViewController.loginTextField.text else { return }
        guard loginViewController.passwordTextField.text != nil else { return }

        profileViewController.profileHeader.profileName.text = "\(login)"
        profileViewController.profileHeader.profilePhoto.image = currentUser.user.image
        profileViewController.profileHeader.backgroundColor = .darkGray
        
        delegate?.didCompleteLogin(coordinator: self)
                
    }
}
