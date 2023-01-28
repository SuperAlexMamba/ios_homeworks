//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Слава Орлов on 28.12.2022.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController{
    
    let profileHeader = ProfileHeaderView()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = .zero
        tableView.headerView(forSection: 0)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
      
    }
    
    private func setupView(){
        profileHeader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addSubview(profileHeader)
        view.backgroundColor = .lightGray
        title = "Profile"

        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.headerView(forSection: 0)
        
        setupConstrains()
    }
    
    private func setupConstrains(){
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
        
            profileHeader.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor, constant: 0),
            profileHeader.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor, constant: 0),
            profileHeader.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            profileHeader.heightAnchor.constraint(equalToConstant: 220),
            
            tableView.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: profileHeader.bottomAnchor, constant: 0)
        ])
    }
}

extension ProfileViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = [postOne,postTwo,postThree,postFour]
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        let data = [postOne,postTwo,postThree,postFour]
        let items = data[indexPath.row]
        
        cell.authorLabel.text = items.author
        cell.descriptionText.text = items.description
        cell.viewsLabel.text = "Views: \(items.views)"
        cell.likesLabel.text = "Likes: \(items.likes)"
        cell.postImage.image = UIImage(named: items.image)
        
        return cell
    }
}
