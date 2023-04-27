//
//  UserService.swift
//  Navigation
//
//  Created by Слава Орлов on 16.03.2023.
//

import Foundation
import UIKit
import FirebaseAuth


protocol UserService {
    func checkLogin(login: String) -> User?
}

protocol LoginViewControllerDelegate {
    func check(login: String , password: String) -> Bool
}

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

protocol CheckerServiceProtocol {
    
    func checkCredentials(login: String, password: String, loginVC: UIViewController, profileVC: UIViewController)
    func signUp(with login: String, and password: String, loginVC: UIViewController, profileVC: UIViewController)
    
}

class CurrentUserService: UserService {
    
    var user = User(login: "Hipster Cat", password: "1234", status: "i am super Cat!", image: UIImage(named: "hipsterCat")!)
    
    func checkLogin(login: String) -> User? {
        if login == user.login {
            return user
        }
        else{return nil}
    }
}

class TestUserService: UserService {
    var testUser = User(login: "Test Cat", password: "1234", status: "TEST", image: UIImage(named: "space")!)
    
    func checkLogin(login: String) -> User? {
        
        if login == testUser.login {
            return testUser
        }
        else{return nil}
    }
}

class Checker: LoginViewControllerDelegate {
    
    static let shared = Checker()
    private init() {}
    
    private let login = "1"
    private let password = "12345"
    
    func check(login: String , password: String) -> Bool {
        
        if login == self.login && password == self.password {
            return true
        }
        else {
            return false
        }
    }
}
    
struct LoginInspector: LoginViewControllerDelegate, CheckerServiceProtocol {

    func checkCredentials(login: String, password: String, loginVC: UIViewController, profileVC: UIViewController) {
        
        guard login != "" , password != "" else {
            showAlert(title: "Please Enter login or password!", message: "", in: loginVC)
            return
        }
        
        Auth.auth().signIn(withEmail: login, password: password) { authDataResult, error in
            
            if let error {
                print(error.localizedDescription)
                let err = error as NSError
                switch err.code {
                    
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    showAlert(title: "Почта используется!", message: "Пожалуйста, введите новый адрес E-Mail", in: loginVC)
                
                case AuthErrorCode.invalidEmail.rawValue:
                    showAlert(title: "Некорректный формат почты", message: "Пожалуйста, проверьте правильность написания E-Mail", in: loginVC)
                    
                case AuthErrorCode.weakPassword.rawValue:
                    showAlert(title: "Некорректный пароль", message: "Длина пароля не должна быть короче 6 символов, повторите ввод", in: loginVC)
                    
                default:
                    showAlert(title: "Что-то пошло не так", message: "\(error.localizedDescription)", in: loginVC)
                }
            }
            
            pushLogin(from: loginVC, to: profileVC)
            
        }
    }
    
    func signUp(with login: String, and password: String, loginVC: UIViewController, profileVC: UIViewController) {
        
        guard login != "" , password != "" else {
            showAlert(title: "Please Enter login or password!", message: "", in: loginVC)
            return
        }
        
        Auth.auth().createUser(withEmail: login, password: password) { authDataResult, error in
            
            if let error {
                print(error.localizedDescription)
                return
            }
         
            pushLogin(from: loginVC, to: profileVC)
            
        }

    }
    
    func check(login: String, password: String) -> Bool {
        
        if Checker.shared.check(login: login, password: password) == true {
            print("YES")
            return true
        }
        else {
            print("NO")
            return false
        }
    }
}

struct MyLoginFactory: LoginFactory {
    
    func makeLoginInspector() -> LoginInspector {
        
        return LoginInspector()
        
    }
}

func showAlert(title: String, message: String, in vc: UIViewController) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Ok", style: .default)
    
    alert.addAction(action)
    
    vc.present(alert, animated: true)
}

func pushLogin(from firstVC: UIViewController, to secondVC: UIViewController) {
    firstVC.navigationController?.pushViewController(secondVC, animated: true)
}
