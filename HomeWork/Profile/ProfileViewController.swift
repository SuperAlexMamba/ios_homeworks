//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Слава Орлов on 28.12.2022.
//

import Foundation
import UIKit
import iOSIntPackage

class ProfileViewController: UIViewController {
    
    let backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .systemGray4)
    
    let labelsColor = UIColor.createColor(lightMode: .black, darkMode: .white)
    
    var profileViewModel = ProfileViewModel()
    var profileHeader = ProfileHeaderView()
    var manager = CoreDataManager()
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    let backgroundView = UIView(frame: UIScreen.main.bounds)
    let closeButton = UIButton(type: .system)
    var originalFrame: CGRect!
    
    var feedViewModel = FeedViewModel()
    
    var tableView: UITableView = {
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
        
        self.profileHeader.delegate = self
                
        self.profileViewModel = ProfileViewModel()
        
        self.originalFrame = profileHeader.profilePhoto.frame

        setupView()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    private func setupView() {
        
        profileHeader.translatesAutoresizingMaskIntoConstraints = false
        profileHeader.backgroundColor = .systemGray4
        
        view.addSubview(tableView)
        view.addSubview(profileHeader)
                    
        title = "profile_key".localized
        view.backgroundColor = backgroundColor
        
        tableView.tintColor = backgroundColor
        tableView.separatorColor = backgroundColor
        
        tableView.dragInteractionEnabled = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        
        self.tableView.headerView(forSection: 0)
        
        profileHeader.photoView.addTarget(self, action: #selector(animateProfilePhoto), for: .touchUpInside)
                
        setupConstrains()
        
    }
    
    private func setupConstrains() {
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
        
    @objc func buttonIsPressed() {
        let photosVC = PhotosViewController()
        self.navigationController?.pushViewController(photosVC, animated: true)
    }
    
    @objc func likePost() {
        
        guard let indexPath = self.tableView.indexPathForSelectedRow?.row else {
            print("Error! IndexPath is nil")
            return
        }
        
        let post = profileViewModel.posts[indexPath]
        
        manager.savePost(post: post, user: superUser)
        
        feedViewModel.didLikedImage(self.view)
        
    }
}

extension ProfileViewController : UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let row = tableView.numberOfRows(inSection: 0)
            destinationIndexPath = IndexPath(row: row, section: 0)
        }
        
        coordinator.session.loadObjects(ofClass: UIImage.self) { (items) in
            guard let images = items as? [UIImage] else { return }
            
            coordinator.session.loadObjects(ofClass: NSString.self) { (items) in
                guard let descriptions = items as? [NSString] else { return }
                
                for (index, image) in images.enumerated() {
                    let description = descriptions[index]
                    
                    let post = Post(author: "Drag&Drop", text: description as String, image: image, likes: 0, views: 0)
                    
                    self.profileViewModel.posts.insert(post, at: destinationIndexPath.row + index)
                }
                
                tableView.insertRows(at: [destinationIndexPath], with: .automatic)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self) || session.canLoadObjects(ofClass: NSString.self)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        
        if tableView.hasActiveDrag {
            return UITableViewDropProposal(operation: .move , intent: .insertAtDestinationIndexPath)
        }
        else {
            return UITableViewDropProposal(operation: .copy, intent: .automatic)
        }
        
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        let post = profileViewModel.posts[indexPath.row]
        
        let image = UIDragItem(itemProvider: NSItemProvider(object: post.image))
        
        let descriptionProvider = NSItemProvider(object: post.text as NSString)
        
        let descriptionDragItem = UIDragItem(itemProvider: descriptionProvider)
        
        descriptionDragItem.localObject = post
        
        return [image, descriptionDragItem]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 1
        }
        else {
            
            let posts = self.profileViewModel.posts

            let data = posts
            return data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as! PhotosTableViewCell
            
            cell.navigationButton.addTarget(self, action: #selector(buttonIsPressed), for: .touchUpInside)
            
            cell.makeBorders()
            
            cell.backgroundColor = self.backgroundColor
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        
        let posts = self.profileViewModel.posts
        
        let items = posts[indexPath.row]
        
        cell.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        cell.layer.borderWidth = 0.5
        
        cell.layer.cornerRadius = 10
        
        cell.clipsToBounds = true
        
        cell.authorLabel.text = "\("source_key".localized) \(items.author)"
        cell.descriptionText.text = items.text
        
        cell.viewsLabel.text = "\("views_key".localized) \(String(describing: items.views))"
        cell.likesLabel.text = "\("likes_key".localized) \(String(describing: items.likes))"
        cell.postImage.image = items.image
        
        cell.userLabel.text = profileHeader.profileName.text
        
        cell.userPhoto.image = profileHeader.profilePhoto.image
        
        cell.backgroundColor = self.backgroundColor
        
        let likePostGuest = UITapGestureRecognizer(target: self, action: #selector(likePost))
        
        likePostGuest.numberOfTapsRequired = 2
        
        cell.addGestureRecognizer(likePostGuest)
        
        let processor = ImageProcessor()
        
        processor.processImage(sourceImage: cell.postImage.image!, filter: .fade) { image in
            cell.postImage.image = image
        }
        
        return cell
    }
    
    // MARK: - Animation
    
    @objc func animateProfilePhoto() {
        
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        backgroundView.backgroundColor = .black
        view.addSubview(backgroundView)
        
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .white
        closeButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        closeButton.addTarget(self, action: #selector(cancelProfilePhotoPressed), for: .touchUpInside)
        
        backgroundView.addSubview(closeButton)

        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        closeButton.bottomAnchor.constraint(equalTo: profileHeader.profilePhoto.topAnchor, constant: 10).isActive = true
        
        backgroundView.alpha = 0.0
        view.bringSubviewToFront(closeButton)
        
        UIView.animate(withDuration: 0.3, delay: 0.3) {
            
            self.backgroundView.alpha = 0.5
            self.profileHeader.profilePhoto.center = CGPoint(x: self.screenWidth / 2 , y: self.screenHeight / 2.5)
            self.profileHeader.profilePhoto.layer.bounds.size = CGSize(width:self.screenWidth, height: self.screenHeight / 2)
            self.profileHeader.profilePhoto.layer.cornerRadius = 0
            self.profileHeader.profilePhoto.layer.borderWidth = 0
            
        }
        
    }
    
    @objc func cancelProfilePhotoPressed() {
                
        let targetFrame = CGRect(x: 0, y: 0, width: originalFrame.width, height: originalFrame.height)
                
        profileHeader.editProfileButton.isHidden = false
        profileHeader.profileStatus.isHidden = false
        profileHeader.statusTextField.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0.1) {
            
            self.profileHeader.profilePhoto.layer.cornerRadius = 50
            self.profileHeader.profilePhoto.layer.borderWidth = 3
            self.profileHeader.profilePhoto.frame = targetFrame
            self.backgroundView.removeFromSuperview()
            self.closeButton.removeFromSuperview()
        }
    }
}
