//
//  PostViewController.swift
//  Navigation
//
//  Created by Слава Орлов on 19.12.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    var titleString: String = "post_title_key".localized
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = titleString
        
        let barButtonItem = UIBarButtonItem(title: "info_button_key".localized, style: .plain, target: self, action: #selector(itemAction))
        self.navigationItem.rightBarButtonItem = barButtonItem

    }
    
    @objc private func itemAction(){
        
        let infoViewController = InfoViewController()
        
        self.navigationController?.pushViewController(infoViewController, animated: true)
        
    }
}
