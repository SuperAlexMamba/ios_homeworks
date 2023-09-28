//
//  FeedableViewController.swift
//  Navigation
//
//  Created by Слава Орлов on 20.09.2023.
//

import UIKit

class FeedViewController: UITableViewController {
    
    let feedViewModel = FeedViewModel()
    
    var manager = CoreDataManager()
    
    let backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .systemGray4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedViewModel.calculate()
        
        setupView()
        
    }
    
    private func setupView() {
        
        self.tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "FeedCell")
        
        self.title = "feed_title_key".localized
        self.view.backgroundColor = backgroundColor
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return feedViewModel.items.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! PostTableViewCell

        feedViewModel.cellSetup(in: cell, in: indexPath)
            
        cell.makeBorders()
        
        let likePostGuest = UITapGestureRecognizer(target: self, action: #selector(likePost))
        
        likePostGuest.numberOfTapsRequired = 2
        
        cell.addGestureRecognizer(likePostGuest)
        
        return cell
    }
    
    @objc func likePost() {
        
        guard let indexPath = self.tableView.indexPathForSelectedRow?.row else {
            print("Error! IndexPath is nil")
            return
        }
        
        let post = feedViewModel.items[indexPath].post
        
        let user = feedViewModel.items[indexPath].user
        
        manager.savePost(post: post, user: user)
        
        feedViewModel.didLikedImage(self.view)
        
    }
}
