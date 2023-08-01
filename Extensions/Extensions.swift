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
