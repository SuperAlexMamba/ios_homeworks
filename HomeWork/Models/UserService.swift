//
//  UserService.swift
//  Navigation
//
//  Created by Слава Орлов on 16.03.2023.
//

import Foundation
import UIKit

protocol UserService {
    func checkLogin(login: String) -> User?
}

protocol LoginViewControllerDelegate {
    func check(login: String , password: String) -> Bool
}

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
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
    
struct LoginInspector: LoginViewControllerDelegate {
    
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
