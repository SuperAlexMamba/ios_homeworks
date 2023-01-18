//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Слава Орлов on 28.12.2022.
//

import Foundation
import UIKit

class ProfileViewContoller: UIViewController{
    
    let profileHeader = ProfileHeaderView()
    
    var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sample Text", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor = .gray

        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileHeader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        view.addSubview(profileHeader)
        view.backgroundColor = .lightGray
        setupConstrains()
        title = "Profile"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
      
    }
    
    private func setupConstrains(){
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
        
            profileHeader.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor, constant: 0),
            profileHeader.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor, constant: 0),
            profileHeader.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            profileHeader.heightAnchor.constraint(equalToConstant: 220),
            
            button.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor, constant: 0),
            button.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor, constant: 0),
            button.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
            
            
        ])
    }
}
