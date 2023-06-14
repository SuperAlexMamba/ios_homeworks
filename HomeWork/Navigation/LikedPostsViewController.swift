//
//  LikedPostsViewController.swift
//  Navigation
//
//  Created by Слава Орлов on 23.05.2023.
//

import UIKit
import CoreData

class LikedPostsViewController: UITableViewController, NSFetchedResultsControllerDelegate {
        
    var manager = CoreDataManager()
        
    lazy var fetchResultController: NSFetchedResultsController = {
        let fethRequest = LikedPost.fetchRequest()
        
        fethRequest.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        
        let frc = NSFetchedResultsController(fetchRequest: fethRequest, managedObjectContext: manager.persistendContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
    
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = fetchResultController.fetchedObjects {
            manager.likedPosts = items
        }
                
        try? fetchResultController.performFetch()

        fetchResultController.delegate = self
        
        setupView()
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return manager.likedPosts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = PostTableViewCell()
        
        let item = manager.likedPosts[indexPath.row]
        
        cell.authorLabel.text = item.author
        cell.descriptionText.text = item.text
        cell.viewsLabel.text = "Views: \(String(describing: item.views))"
        cell.likesLabel.text = "Likes: \(String(describing: item.likes))"
        cell.postImage.image = UIImage(named: item.image!)
        
        return cell
    }
        
    @objc func resetFilter() {
        manager.likedPosts = fetchResultController.fetchedObjects!
        try? fetchResultController.performFetch()
        tableView.reloadData()
    
    }
    
    @objc func searchPost() {
        
        let alert = UIAlertController(title: "Filter", message: "Enter the author of the post", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "author"
        }
        
        let searchAction = UIAlertAction(title: "Search", style: .default) { [weak alert , weak self] _ in
            
            guard let textField = alert?.textFields?.first else { return }
            
            if let text = textField.text , text != "" {
                self?.manager.likedPosts = (self?.manager.likedPosts.filter({$0.author?.contains(text) ?? false}))!
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
        alert.addAction(searchAction)
        
        self.present(alert, animated: true)
        
    }
    
    private func setupView() {
                
        let searchNavigationButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchPost))
        
        let resetFilterButton = UIBarButtonItem(title: "Reset", style: .done, target: self, action: #selector(resetFilter))
        
        self.navigationItem.leftBarButtonItem = searchNavigationButton
        
        self.navigationItem.rightBarButtonItem = resetFilterButton
        
        title = "Liked Posts"
        
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { [weak self] (action, view, completion) in
            self?.manager.deletePost(post: (self?.manager.likedPosts[indexPath.row])!)
            try? self?.fetchResultController.performFetch()
            completion(true)
        }
        deleteAction.backgroundColor = .systemRed
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return configuration
    }
        
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        try? fetchResultController.performFetch()
        
        self.tableView.reloadData()
        
    }
}

extension LikedPostsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
}
