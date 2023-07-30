//
//  PostViewController.swift
//  Navigation
//
//  Created by Слава Орлов on 19.12.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    var titleString: String = NSLocalizedString("post_title_key", comment: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = titleString
        
        let barButtonItem = UIBarButtonItem(title: NSLocalizedString("info_button_key", comment: ""), style: .plain, target: self, action: #selector(itemAction))
        self.navigationItem.rightBarButtonItem = barButtonItem

    }
    
    @objc private func itemAction(){
        
        let infoViewController = InfoViewController()
        
        self.navigationController?.pushViewController(infoViewController, animated: true)
        
    }
}
