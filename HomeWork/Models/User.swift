//
//  User.swift
//  Navigation
//
//  Created by Слава Орлов on 04.03.2023.
//

import Foundation
import UIKit

protocol UserService {
    func checkLogin(login: String) -> User?
}

class User {
    
    var login: String
    var password: String
    var status: String
    var image: UIImage
    
    init(login: String, password: String, status: String, image: UIImage) {
        self.login = login
        self.password = password
        self.status = status
        self.image = image
    }
}

class CurrentUserService: UserService {
    var user: User?
    
    func checkLogin(login: String) -> User? {
        if login == user?.login {
            return user
        }
        else{return nil}
    }
}
