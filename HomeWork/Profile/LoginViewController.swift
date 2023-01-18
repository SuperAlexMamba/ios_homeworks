//
//  LoginViewController.swift
//  Navigation
//
//  Created by Слава Орлов on 16.01.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    var stackView: UIStackView = {
       let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    var logoImage: UIImageView = {
        
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logoVK")
        return image
    }()
    
    var loginTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Email or phone"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16, weight: .light, width: .standard)
        textField.tintColor = .tintColor
        textField.autocapitalizationType = .none
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        return textField
    }()
    
    var passwordTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16, weight: .light, width: .standard)
        textField.tintColor = .tintColor
        textField.autocapitalizationType = .none
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.isSecureTextEntry = true
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        return textField
    }()
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log in", for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        switch button.state{
            
        case .normal: button.alpha = 1
        case .selected: button.alpha = 0.8
        case .highlighted: button.alpha = 0.8
        case .disabled: button.alpha = 0.8
        default: button.alpha = 1
        }
    
       return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        
        self.view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        setupScrollView()

        loginButton.addTarget(self, action: #selector(buttonIsPressed), for: .touchUpInside)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    
    @objc private func buttonIsPressed(){
        let profileViewController = ProfileViewContoller()
        self.tabBarController?.present(profileViewController, animated: true) //не получается Present Modally, через метод push контроллер не появляется (пробовал и через свойство navigationController)
        }
    
    @objc func willShowKeyboard(_ notification: NSNotification){
        
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        scrollView.contentInset.bottom += keyboardHeight ?? 0.0
        
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification){
        
        scrollView.contentInset.bottom = 0.0
        
    }
    
    private func setupScrollView(){
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(loginButton)
        contentView.addSubview(logoImage)
        contentView.addSubview(stackView)
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
                
            scrollView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: safeAreaGuide.widthAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        
        ])
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
        
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            
            loginButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            loginButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            loginButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupKeyboardObservers(){
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self,
                                       selector: #selector(self.willShowKeyboard(_:)),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(self.willHideKeyboard(_:)),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
    }
    
    private func removeKeyboardObservers(){
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
}

extension LoginViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
