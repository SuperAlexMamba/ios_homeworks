//
//  Photo.swift
//  Navigation
//
//  Created by Слава Орлов on 27.01.2023.
//

import Foundation
import UIKit

class PhotosArray {
    
    static let shared = PhotosArray()
        
    var photosArray: [UIImage]
    
    init() {
        self.photosArray = [UIImage]()
        
        photosArray.append(UIImage(named: "1")!)
        photosArray.append(UIImage(named: "2")!)
        photosArray.append(UIImage(named: "3")!)
        photosArray.append(UIImage(named: "4")!)
        photosArray.append(UIImage(named: "5")!)
        photosArray.append(UIImage(named: "6")!)
        photosArray.append(UIImage(named: "7")!)
        photosArray.append(UIImage(named: "8")!)
        photosArray.append(UIImage(named: "9")!)
        photosArray.append(UIImage(named: "10")!)
        photosArray.append(UIImage(named: "11")!)
        photosArray.append(UIImage(named: "12")!)
        photosArray.append(UIImage(named: "13")!)
        photosArray.append(UIImage(named: "14")!)
        photosArray.append(UIImage(named: "15")!)
        photosArray.append(UIImage(named: "16")!)
        photosArray.append(UIImage(named: "17")!)
        photosArray.append(UIImage(named: "18")!)
        photosArray.append(UIImage(named: "19")!)
        photosArray.append(UIImage(named: "20")!)

    }

}

