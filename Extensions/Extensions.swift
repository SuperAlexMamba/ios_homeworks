//
//  Extensions.swift
//  Navigation
//
//  Created by Слава Орлов on 31.07.2023.
//

import Foundation
import UIKit

extension String {
    
    var localized: String {
        NSLocalizedString(self, comment: self)
    }
}

extension UIColor {
    
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        
        guard #available(iOS 13.0, *) else {
            return lightMode
        }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}

extension UITableViewCell {
    
    func makeBorders() {
        
        self.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.borderWidth = 0.7
        self.layer.cornerRadius = 10
        self.clipsToBounds = true

    }
    
}
