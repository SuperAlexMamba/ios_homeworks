//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Слава Орлов on 28.12.2022.
//

import Foundation
import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    
    private var statusText: String!
    
    var delegate: ProfileViewController?
        
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
        textField.placeholder = "enter_new_status_placeholder_key".localized
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
    
    var editProfileButton: UIButton = {
        
        let button = CustomButton(title: "show_status_button_key".localized, titleColor: .black, backColor: .gray, mask: false)
        
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.layer.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.borderWidth = 1
        button.contentMode = .center
        button.layer.cornerRadius = 15
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 2
        button.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOpacity = 0.5
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        statusTextField.delegate = self
                
        self.addSubview(profileName)
        self.addSubview(profileStatus)
        self.addSubview(editProfileButton)
        self.addSubview(statusTextField)
        self.addSubview(profilePhoto)
        self.addSubview(photoView)
        
        editProfileButton.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
                
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func editProfile() {
        
        
        let alert = UIAlertController(title: "show_status_button_key".localized, message: "", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "enter_new_nick_placeholder_key".localized
        }
        
        let textField = alert.textFields?.first
        
        let action = UIAlertAction(title: "OK", style: .default) { [weak self] action in
            
            if ((textField?.text) != nil) && textField?.text != "" {
                
                DispatchQueue.main.async {
                    
                    self?.profileName.text = textField?.text
                    superUser.login = (textField?.text)!
                    self?.delegate?.tableView.reloadData()
                                        
                }
            }
            else {
                Picker.shared.showAlert(title: "error_key".localized, message: "Введите логин!", style: .alert, in: (self?.delegate)!)
            }
        }
        
        alert.addAction(action)
        
        delegate?.present(alert, animated: true)
        
        
    }
    
    private func buttonPressed() {
        
        guard statusText != nil && statusText != "" else { profileStatus.text = "Waiting for something..."; return }
        profileStatus.text = statusText
    }
    
    private func statusTextIsChanged(_ textField: UITextField) {
        
        statusText = textField.text
    }
        
    private func setConstraints() {
        
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
            $0.width.equalTo(150)
            $0.height.equalTo(50)
        }
        editProfileButton.snp.makeConstraints {
            $0.left.equalTo(safeArea.snp.left).offset(16)
            $0.right.equalTo(safeArea.snp.right).offset(-16)
            $0.top.equalTo(profilePhoto.snp.bottom).offset(32)
            $0.height.equalTo(40)
        }
        profileStatus.snp.makeConstraints {
            $0.right.equalTo(safeArea.snp.right).offset(-90)
            $0.centerY.equalTo(editProfileButton.snp.top).offset(-70)
            $0.width.equalTo(160)
            $0.height.equalTo(100)
        }
        statusTextField.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(228)
            $0.top.equalTo(editProfileButton.snp.top).offset(-55)
            $0.right.equalTo(safeArea.snp.right).offset(-20)
        }
    }
}

extension ProfileHeaderView: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        statusTextIsChanged(textField)
        
        buttonPressed()
                
        return textField.resignFirstResponder()
        
    }
    
    
}

