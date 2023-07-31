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
