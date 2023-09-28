//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Слава Орлов on 05.04.2023.
//

import Foundation
import StorageService
import UIKit

class ProfileViewModel {
    
    var posts: [Post] = [postOne,postTwo,postThree,postFour]
            
    let xPhotoPosition = ProfileHeaderView().profilePhoto.bounds.origin.x
    let yPhotoPosition = ProfileHeaderView().profilePhoto.bounds.origin.y
    
    let currentUser = CurrentUserService()
    let testUser = TestUserService()
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
}
