//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Слава Орлов on 28.12.2022.
//

import Foundation
import UIKit

class ProfileHeaderView: UIView{
    
    var profilePhoto: UIImageView!
    var profileStatus: UILabel!
    var profileName: UILabel!
    var showStatusButton: UIButton!
    var statusTextField: UITextField!
    
    private var statusText: String!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        profilePhoto = UIImageView()
        profilePhoto.translatesAutoresizingMaskIntoConstraints = false
        profilePhoto.image = UIImage(named: "hipsterCat")
        profilePhoto.clipsToBounds = true
        profilePhoto.layer.borderWidth = 3
        profilePhoto.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        profilePhoto.layer.cornerRadius = 50
        
        self.addSubview(profilePhoto)
        
        profileName = UILabel()
        profileName.translatesAutoresizingMaskIntoConstraints = false

        profileName.text = "Hipster Cat"
        profileName.font = .systemFont(ofSize: 18, weight: .bold)
        profileName.textColor = .black
        
        self.addSubview(profileName)
        
        profileStatus = UILabel()
        profileStatus.translatesAutoresizingMaskIntoConstraints = false

        profileStatus.text = "Waiting for something..."
        profileStatus.font = .systemFont(ofSize: 14, weight: .regular)
        profileStatus.textColor = .gray
        
        self.addSubview(profileStatus)
        
        showStatusButton = UIButton()
        showStatusButton.translatesAutoresizingMaskIntoConstraints = false

        showStatusButton.setTitle("Show status", for: .normal)
        showStatusButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        showStatusButton.titleLabel?.textColor = .black
        showStatusButton.contentMode = .center

        showStatusButton.backgroundColor = .systemBlue
        showStatusButton.layer.cornerRadius = 15
        
        showStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        showStatusButton.layer.shadowRadius = 4
        showStatusButton.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        showStatusButton.layer.shadowOpacity = 0.7
        
        showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        self.addSubview(showStatusButton)
        
        statusTextField = UITextField()
        statusTextField.translatesAutoresizingMaskIntoConstraints = false

        statusTextField.backgroundColor = .white
        statusTextField.font = .systemFont(ofSize: 15, weight: .regular)
        statusTextField.textColor = .black
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        statusTextField.addTarget(self, action: #selector(statusTextIsChanged), for: .editingChanged)
        
        self.addSubview(statusTextField)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonPressed(){
        
        profileStatus.text = statusText
        
        guard statusText != nil else {return}
        print(profileStatus.text!)
    }
    
    @objc func statusTextIsChanged(_ textField: UITextField){
        
        statusText = textField.text
    }
    
    private func setConstraints(){
        
        NSLayoutConstraint.activate([
            
            profilePhoto.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            profilePhoto.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            profilePhoto.widthAnchor.constraint(equalToConstant: 100),
            profilePhoto.heightAnchor.constraint(equalToConstant: 100),
            
            profileName.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 0),
            profileName.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            profileName.widthAnchor.constraint(equalToConstant: 100),
            profileName.heightAnchor.constraint(equalToConstant: 100),
            
            showStatusButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            showStatusButton.widthAnchor.constraint(equalToConstant: 355),
            showStatusButton.heightAnchor.constraint(equalToConstant: 50),
            showStatusButton.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 32),
            
            profileStatus.centerXAnchor.constraint(equalTo: showStatusButton.centerXAnchor, constant: 30),
            profileStatus.centerYAnchor.constraint(equalTo: showStatusButton.topAnchor, constant: -70),
            profileStatus.widthAnchor.constraint(greaterThanOrEqualToConstant: 160),
            profileStatus.heightAnchor.constraint(equalToConstant: 100),
            
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.widthAnchor.constraint(equalToConstant: 228),
            statusTextField.topAnchor.constraint(equalTo: showStatusButton.topAnchor, constant: -55),
            statusTextField.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
}
