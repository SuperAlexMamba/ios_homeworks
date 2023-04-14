//
//  Struct.swift
//  Navigation
//
//  Created by Слава Орлов on 20.12.2022.
//

import Foundation

class FeedModel {

    let secretWord = "Test"
    
    func check(inputWord: String ) -> Bool {
        
        if inputWord == secretWord{
            return true
        }
        else {
            return false
        }
    }
}
