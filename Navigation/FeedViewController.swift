//
//  FeedViewController.swift
//  Navigation
//
//  Created by Слава Орлов on 19.12.2022.
//

import UIKit

class FeedViewController: UIViewController {

    var button = UIButton(frame: CGRectMake(150, 240, 90, 30))
    
    var post = Post(title: "Netology")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

    }
    
    private func setupView(){
        title = "Feed"
        view.backgroundColor = .white
        button.setTitle("Go To Post", for: .normal)
        button.addTarget(self, action: #selector(buttonIsPressed), for: .touchUpInside)
        button.backgroundColor = .gray
        view.addSubview(button)
    }
    
    @objc private func buttonIsPressed(){
        
        let postViewController = PostViewController()
        
        self.navigationController?.pushViewController(postViewController, animated: true)
        
        postViewController.titleString = post.title
    
    }
    
}
