//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Слава Орлов on 28.12.2022.
//

import Foundation
import UIKit
import SnapKit

class ProfileHeaderView: UIView{
        
    private var statusText: String!
    
    var profilePhoto: UIImageView = {
        
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "hipsterCat")
        image.clipsToBounds = true
        image.layer.borderWidth = 3
        image.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        image.layer.cornerRadius = 50
        image.isUserInteractionEnabled = true
        return image
    }()
    
    lazy var photoView: UIButton = {
        let view = UIButton()
        view.tintColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var profileName: UILabel = {
        
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Hipster Cat"
        name.font = .systemFont(ofSize: 18, weight: .bold)
        name.textColor = .black
        
        return name
    }()
    
    var statusTextField: UITextField = {
        
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.backgroundColor = .white
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        return textField
    }()
    
    var profileStatus: UILabel = {
        
        let status = UILabel()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.text = "Waiting for something..."
        status.font = .systemFont(ofSize: 14, weight: .regular)
        status.textColor = .gray
        return status
    }()
    
    var showStatusButton: UIButton = {
       
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show status", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.titleLabel?.textColor = .black
        button.contentMode = .center
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOpacity = 0.7
       return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(profileName)
        self.addSubview(profileStatus)
        self.addSubview(showStatusButton)
        self.addSubview(statusTextField)
        self.addSubview(profilePhoto)
        self.addSubview(photoView)

        showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        statusTextField.addTarget(self, action: #selector(statusTextIsChanged), for: .editingChanged)

        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonPressed(){
        
        guard statusText != nil && statusText != "" else {profileStatus.text = "Waiting for something..."; return}
        profileStatus.text = statusText
        print(profileStatus.text!)
    }
    
    @objc func statusTextIsChanged(_ textField: UITextField){
        
        statusText = textField.text
    }
    
    private func setConstraints(){
        
        let safeArea = safeAreaLayoutGuide
        
        profilePhoto.snp.makeConstraints {
            $0.left.equalTo(safeArea.snp.left).offset(16)
            $0.top.equalTo(safeArea.snp.top).offset(16)
            $0.width.equalTo(100)
            $0.height.equalTo(100)
        }
        photoView.snp.makeConstraints {
            $0.left.equalTo(safeArea.snp.left).offset(16)
            $0.top.equalTo(safeArea.snp.top).offset(16)
            $0.width.equalTo(100)
            $0.height.equalTo(100)
        }
        profileName.snp.makeConstraints {
            $0.centerX.equalTo(safeArea.snp.centerX).offset(0)
            $0.centerY.equalTo(safeArea.snp.top).offset(27)
            $0.width.equalTo(100)
            $0.height.equalTo(100)
        }
        showStatusButton.snp.makeConstraints {
            $0.left.equalTo(safeArea.snp.left).offset(16)
            $0.right.equalTo(safeArea.snp.right).offset(-16)
            $0.width.equalTo(355)
            $0.height.equalTo(50)
            $0.top.equalTo(profilePhoto.snp.bottom).offset(32)
        }
        profileStatus.snp.makeConstraints {
            $0.centerX.equalTo(showStatusButton.snp.centerX).offset(30)
            $0.centerY.equalTo(showStatusButton.snp.top).offset(-70)
            $0.width.equalTo(160)
            $0.height.equalTo(100)
        }
        statusTextField.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(228)
            $0.top.equalTo(showStatusButton.snp.top).offset(-55)
            $0.right.equalTo(safeArea.snp.right).offset(-20)
        }
    }
}
