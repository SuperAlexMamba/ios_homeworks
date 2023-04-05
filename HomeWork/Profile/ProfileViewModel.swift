//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Слава Орлов on 05.04.2023.
//

import Foundation
import StorageService

class ProfileViewModel {
    
    let posts: [Post] = [postOne,postTwo,postThree,postFour]
            
    let xPhotoPosition = ProfileHeaderView().profilePhoto.bounds.origin.x
    let yPhotoPosition = ProfileHeaderView().profilePhoto.bounds.origin.y
    
}
