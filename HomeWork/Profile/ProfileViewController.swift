//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Слава Орлов on 28.12.2022.
//

import Foundation
import UIKit
import StorageService

class ProfileViewController: UIViewController{
    
    let posts: [Post] = [postOne,postTwo,postThree,postFour]
    
    var user = User(login: "Hipster Cat", password: "1234", status: "i am super Cat!", image: UIImage(named: "hipsterCat")!)
        
    let profileHeader = ProfileHeaderView()
    let profilePhoto = ProfileHeaderView().profilePhoto
    
    let xPhotoPosition = ProfileHeaderView().profilePhoto.bounds.origin.x
    let yPhotoPosition = ProfileHeaderView().profilePhoto.bounds.origin.y
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    var cancelButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 1.1 , y: UIScreen.main.bounds.height / 4, width: 40, height: 40))

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = .zero
        tableView.headerView(forSection: 0)
        
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        addGuestRecognizer()
        setupView()
        self.cancelButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        self.cancelButton.addTarget(nil, action: #selector(cancelProfilePhotoPressed), for: .touchUpInside)
                
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
      
    }
    
    private func setupView(){
        profileHeader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addSubview(profileHeader)
        
        profileHeader.profilePhoto.image = user.image
        profileHeader.profileStatus.text = user.status
        profileHeader.profileName.text = user.login
        
        #if DEBUG
        view.backgroundColor = .lightGray
        #else
        view.backgroundColor = .red
        #endif
        title = "Profile"

        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.headerView(forSection: 0)
        setupConstrains()
    }
    
    func addGuestRecognizer(){
        let guest = UITapGestureRecognizer(target: self, action: #selector (animateProfilePhoto))
        profileHeader.photoView.addGestureRecognizer(guest)
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
            tableView.topAnchor.constraint(equalTo: profileHeader.bottomAnchor, constant: 0),

        ])
    }
        
    @objc func buttonIsPressed(){
        let photosVC = PhotosViewController()
        self.navigationController?.pushViewController(photosVC, animated: true)
    }
}

extension ProfileViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 1
        }
        else{
            let data = [postOne,postTwo,postThree,postFour]
            return data.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as! PhotosTableViewCell
            
            cell.navigationButton.addTarget(self, action: #selector(buttonIsPressed), for: .touchUpInside)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        
        let items = self.posts[indexPath.row]
        
        cell.authorLabel.text = items.author
        cell.descriptionText.text = items.description
        cell.viewsLabel.text = "Views: \(items.views)"
        cell.likesLabel.text = "Likes: \(items.likes)"
        cell.postImage.image = UIImage(named: items.image)
        
        return cell
    }
    
    // MARK: - Animation
    
    @objc func animateProfilePhoto(){

        view.addSubview(backgroundView)
        view.addSubview(cancelButton)
        profileHeader.showStatusButton.isHidden = true
        profileHeader.profileStatus.isHidden = true
        profileHeader.statusTextField.isHidden = true
        view.insertSubview(backgroundView, at: 1)
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0.0
        UIView.animate(withDuration: 0.3, delay: 0.3) {
            self.backgroundView.alpha = 0.5
            self.profileHeader.profilePhoto.center = CGPoint(x: self.screenWidth / 2 , y: self.screenHeight / 2)
            self.profileHeader.profilePhoto.layer.bounds.size = CGSize(width:self.screenWidth, height: self.screenHeight / 2)
            self.profileHeader.profilePhoto.layer.cornerRadius = 0
            self.profileHeader.profilePhoto.layer.borderWidth = 0
            
        }
    }
    
    @objc func cancelProfilePhotoPressed(){
        
        profileHeader.showStatusButton.isHidden = false
        profileHeader.profileStatus.isHidden = false
        profileHeader.statusTextField.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0.3) {
            self.profileHeader.profilePhoto.center = CGPoint(x: self.yPhotoPosition, y: self.yPhotoPosition)
            self.profileHeader.profilePhoto.layer.bounds.size = CGSize(width: 100, height: 100)
            self.profileHeader.profilePhoto.layer.cornerRadius = 50
            self.profileHeader.profilePhoto.layer.borderWidth = 3
            self.backgroundView.removeFromSuperview()
            self.cancelButton.removeFromSuperview()
        }
    }
}
