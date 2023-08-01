//
//  LikedPostsViewController.swift
//  Navigation
//
//  Created by Слава Орлов on 23.05.2023.
//

import UIKit
import CoreData

class LikedPostsViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .systemGray4)
        
    var manager = CoreDataManager()
        
    lazy var fetchResultController: NSFetchedResultsController = {
        let fethRequest = LikedPost.fetchRequest()
        
        fethRequest.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        
        let frc = NSFetchedResultsController(fetchRequest: fethRequest, managedObjectContext: manager.persistendContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
    
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        fetchResultController.delegate = self
        
        setupView()
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchResultController.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = PostTableViewCell()
        
        let item = fetchResultController.object(at: indexPath)
        
        cell.authorLabel.text = item.author
        cell.descriptionText.text = item.text
        cell.viewsLabel.text = "\("views_key".localized) \(String(describing: item.views))"
        cell.likesLabel.text = "\("likes_key".localized) \(String(describing: item.likes))"
        cell.postImage.image = UIImage(named: item.image!)
        
        return cell
    }
        
    @objc func resetFilter() {
        
        fetchResultController.fetchRequest.predicate = NSPredicate(value: true)
                
        try? fetchResultController.performFetch()
        
        tableView.reloadData()
    
    }
    
    @objc func searchPost() {
        
        let alert = UIAlertController(title: "filter_key".localized, message: "alert_filter_message".localized, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "author_key".localized
        }
        
        let searchAction = UIAlertAction(title: "search_key".localized, style: .default) { [weak alert , weak self] _ in
            
            guard let fetchController = self?.fetchResultController else { return }
            
            guard let textField = alert?.textFields?.first else { return }
            
            if let text = textField.text , text != "" {
                
                fetchController.fetchRequest.predicate = NSPredicate(format: "(author contains[cd] %@)", text)
                
                try? fetchController.performFetch()
                
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
        
        let resetFilterButton = UIBarButtonItem(title: "reset_button_liked_posts_key".localized, style: .done, target: self, action: #selector(resetFilter))
        
        self.navigationItem.leftBarButtonItem = searchNavigationButton
        
        self.navigationItem.rightBarButtonItem = resetFilterButton
        
        view.backgroundColor = self.backgroundColor
        
        title = "liked_posts_title_key".localized
        
        try? fetchResultController.performFetch()
        
        tableView.reloadData()
        
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "delete_key".localized) { [weak self] (action, view, completion) in
            self?.manager.deletePost(post: (self?.fetchResultController.object(at: indexPath))!)
            completion(true)
        }
        deleteAction.backgroundColor = .systemRed
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return configuration
    }
        
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        case .update:
            try? fetchResultController.performFetch()
            tableView.reloadData()
        @unknown default:
            ()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}

extension LikedPostsViewController: UITextFieldDelegate, UITabBarControllerDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        try? fetchResultController.performFetch()
        tableView.reloadData()
        
    }
    
}
