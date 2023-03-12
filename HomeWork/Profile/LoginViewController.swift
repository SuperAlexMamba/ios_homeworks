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
    
    var currentUser = CurrentUserService()
    var testUser = TestUserService()
            
    var stackView: UIStackView = {
       let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = .init(red: 0.128, green: 0.128, blue: 0.128, alpha: 1)
        stackView.layer.cornerRadius = 10
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
        
    var uiView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var logoImage: UIImageView = {
        
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logoVK")
        return image
    }()
    
    var loginTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "  Email or phone"
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16, weight: .light, width: .standard)
        textField.tintColor = .tintColor
        textField.autocapitalizationType = .none
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        return textField
    }()
    
    var passwordTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "  Password"
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16, weight: .light, width: .standard)
        textField.autocapitalizationType = .none
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
        stackView.addArrangedSubview(uiView)
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
        let profileViewController = ProfileViewController()
        
        guard let login = loginTextField.text else {return}
        
        #if DEBUG
        if (testUser.checkLogin(login: login)) != nil{
            self.navigationController?.pushViewController(profileViewController, animated: true)
            print("Успешная авторизация ")
        }
        else{
            errorLoginAlert()
        }
        #else
        if (currentUser.checkLogin(login: login)) != nil{
            self.navigationController?.pushViewController(profileViewController, animated: true)
            print("Успешная авторизация ")
        }
        else{
            errorLoginAlert()
        }
        #endif
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
            
            uiView.heightAnchor.constraint(equalToConstant: 0.5),
            
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
    
    private func errorLoginAlert(){
        
        let alert = UIAlertController(title: "Error", message: "invalid Login. Enter valid login", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
        
    }
    
}

extension LoginViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
