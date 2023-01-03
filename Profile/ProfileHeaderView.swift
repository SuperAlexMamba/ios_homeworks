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
        
        profilePhoto = UIImageView(frame: CGRect(x: 20, y: 95, width: 100, height: 100))
        profilePhoto.image = UIImage(named: "hipsterCat")
        profilePhoto.clipsToBounds = true
        profilePhoto.layer.borderWidth = 3
        profilePhoto.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        profilePhoto.layer.cornerRadius = 50
        
        
        self.addSubview(profilePhoto)
        
        profileName = UILabel(frame: CGRect(x: 150, y: 70, width: 100, height: 100))
        profileName.text = "Hipster Cat"
        profileName.font = .systemFont(ofSize: 18, weight: .bold)
        profileName.textColor = .black
        
        self.addSubview(profileName)
        
        profileStatus = UILabel(frame: CGRect(x: 150, y: 120, width: 160, height: 100))
        profileStatus.text = "Waiting for something..."
        profileStatus.font = .systemFont(ofSize: 14, weight: .regular)
        profileStatus.textColor = .gray
        
        self.addSubview(profileStatus)
        
        showStatusButton = UIButton(frame: CGRect(x: 27, y: 250, width: 350, height: 55))
        showStatusButton.setTitle("Show status", for: .normal)
        showStatusButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        showStatusButton.titleLabel?.textColor = .black

        showStatusButton.backgroundColor = .systemBlue
        showStatusButton.layer.cornerRadius = 15
        
        showStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        showStatusButton.layer.shadowRadius = 4
        showStatusButton.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        showStatusButton.layer.shadowOpacity = 0.7
        
        showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        self.addSubview(showStatusButton)
        
        statusTextField = UITextField(frame: CGRect(x: 150, y: 180, width: 228, height: 45))
        statusTextField.backgroundColor = .white
        statusTextField.font = .systemFont(ofSize: 15, weight: .regular)
        statusTextField.textColor = .black
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        statusTextField.addTarget(self, action: #selector(statusTextIsChanged), for: .editingChanged)
        
        self.addSubview(statusTextField)
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
    
}

