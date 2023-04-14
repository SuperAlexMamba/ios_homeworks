//
//  PostViewController.swift
//  Navigation
//
//  Created by Слава Орлов on 19.12.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    var titleString: String = "Netology"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = titleString
        
        let barButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(itemAction))
        self.navigationItem.rightBarButtonItem = barButtonItem

    }
    
    @objc private func itemAction(){
        
        let infoViewController = InfoViewController()
        
        self.navigationController?.pushViewController(infoViewController, animated: true)
        
    }
}
