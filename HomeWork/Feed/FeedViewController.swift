//
//  FeedViewController.swift
//  Navigation
//
//  Created by Слава Орлов on 19.12.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var showPost: () -> () = { }
    
    var feedViewModel: FeedViewModel?

    var firstButton = CustomButton(title: "Go to Post", titleColor: .white, backColor: .gray, mask: false)
    var secondButton = CustomButton(title: "Go to Post", titleColor: .white, backColor: .gray, mask: false)
    
    var stackView = UIStackView()
    
    var textField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black

        textField.layer.borderWidth = 1
        textField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        return textField
    }()
    
    var resultLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "RESULT"
        label.textColor = .black
        return label
    }()
    
    var checkButton = CustomButton(title: "Check!", titleColor: .white, backColor: .black, mask: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedViewModel = FeedViewModel()
        
        setupView()
        
        checkButton.tapAction = {
            
            guard let text = self.textField.text else {return}
            
            if self.feedViewModel?.secretword.check(inputWord: text) == true{
                self.resultLabel.textColor = .green
            }
            else{
                self.resultLabel.textColor = .red
            }
        }

    }
    
    private func setupView() {
        title = "Feed"
        view.backgroundColor = .white
        
        firstButton.addTarget(self, action: #selector(buttonIsPressed), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(buttonIsPressed), for: .touchUpInside)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        view.addSubview(resultLabel)
        view.addSubview(textField)
        view.addSubview(checkButton)

        setupConstrains()
        
    }
    
    @objc private func buttonIsPressed() {
        showPost()
    }
    
    private func setupConstrains() {
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
        
            stackView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor),
            
            textField.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 30),
            textField.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor, constant: 30),
            textField.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor, constant: -30),
            textField.heightAnchor.constraint(equalToConstant: 30),
            
            checkButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15),
            checkButton.centerXAnchor.constraint(equalTo: textField.centerXAnchor),
            checkButton.heightAnchor.constraint(equalToConstant: 50),
            checkButton.widthAnchor.constraint(equalToConstant: 80),
            
            resultLabel.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 5),
            resultLabel.centerXAnchor.constraint(equalTo: textField.centerXAnchor),
            resultLabel.widthAnchor.constraint(equalToConstant: 80),
            resultLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
