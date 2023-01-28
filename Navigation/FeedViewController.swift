//
//  FeedViewController.swift
//  Navigation
//
//  Created by Слава Орлов on 19.12.2022.
//

import UIKit

class FeedViewController: UIViewController {

    var firstButton = UIButton()
    var secondButton = UIButton()
    
    var stackView = UIStackView()
    
    var post = Post(title: "Netology")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

    }
    
    private func setupView(){
        title = "Feed"
        view.backgroundColor = .white
        firstButton.setTitle("Go To Post", for: .normal)
        firstButton.addTarget(self, action: #selector(buttonIsPressed), for: .touchUpInside)
        firstButton.backgroundColor = .gray
        
        secondButton.setTitle("Go To Post", for: .normal)
        secondButton.addTarget(self, action: #selector(buttonIsPressed), for: .touchUpInside)
        secondButton.backgroundColor = .gray
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        setupConstrains()
        
    }
    
    @objc private func buttonIsPressed(){
        
        let postViewController = PostViewController()
        
        self.navigationController?.pushViewController(postViewController, animated: true)
        
        postViewController.titleString = post.title
    
    }
    
    private func setupConstrains(){
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
        
            stackView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor)
        
        ])
    }
}
