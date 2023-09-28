//
//  Button.swift
//  Navigation
//
//  Created by Слава Орлов on 22.03.2023.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    var tapAction: (() -> ())?
    
    init(title: String, titleColor: UIColor, backColor: UIColor, mask: Bool) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = mask
        setTitle(title, for: .normal)
        titleLabel?.tintColor = titleColor
        backgroundColor = backColor
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func buttonTapped() {
        tapAction?()
    }
    
}
