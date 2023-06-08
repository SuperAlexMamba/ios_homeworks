//
//  LikedPostsViewController.swift
//  Navigation
//
//  Created by Слава Орлов on 23.05.2023.
//

import UIKit

class LikedPostsViewController: UITableViewController {
        
    var manager = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        manager.fetchPost()
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return manager.filteredPosts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = PostTableViewCell()
        
        let item = manager.filteredPosts[indexPath.row]
        
        cell.authorLabel.text = item.author
        cell.descriptionText.text = item.text
        cell.viewsLabel.text = "Views: \(String(describing: item.views))"
        cell.likesLabel.text = "Likes: \(String(describing: item.likes))"
        cell.postImage.image = UIImage(named: item.image!)
        
        
        return cell
    }
        
    @objc func resetFilter() {
        manager.fetchPost()
        tableView.reloadData()
    
    }
    
    @objc func searchPost() {
        
        let alert = UIAlertController(title: "Filter", message: "Enter the author of the post", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "author"
        }
        
        let searchAction = UIAlertAction(title: "Search", style: .default) { [weak alert] _ in
            
            guard let textField = alert?.textFields?.first else { return }
            
            if let text = textField.text , text != "" {
                self.manager.searchPost(author: text)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
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
            self?.manager.deletePost(at: indexPath.row)
            
            DispatchQueue.main.async {
                self?.manager.fetchPost()
                tableView.reloadData()
            }
            completion(true)
        }
        deleteAction.backgroundColor = .systemRed
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return configuration
    }

}

extension LikedPostsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
}
