//
//  Picker.swift
//  Navigation
//
//  Created by Слава Орлов on 08.06.2023.
//

import Foundation
import UIKit

class Picker {
    
    static let shared = Picker()
    
    private init() {}
    
    func showAlert(title: String, message: String, style: UIAlertController.Style, in vc: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let action = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(action)
        
        vc.present(alert, animated: true)
        
    }
    
}
