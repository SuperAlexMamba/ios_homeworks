//
//  User.swift
//  Navigation
//
//  Created by Слава Орлов on 04.03.2023.
//

import Foundation
import UIKit

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
