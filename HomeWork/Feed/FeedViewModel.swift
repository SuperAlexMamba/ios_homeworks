//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Слава Орлов on 05.04.2023.
//

import Foundation
import UIKit

class FeedViewModel {
    
    let users: [User] = [userOne,
                         userTwo,
                         userThree]
    
    var items: [FeedItem] = []
    
    var feedPosts: [Post]?
    
    func calculate() {
        
        var feedItems: [FeedItem] = []
        
        for user in self.users {
            
            for post in user.post {
                
                feedItems.append(FeedItem(user: user, 
                                          post: post))
            }
        }
        items = feedItems
    }
        
    func didLikedImage(_ view: UIView) {
        
        let safeArea = view.safeAreaLayoutGuide
        
        let likedImageView = UIImageView()
        
        likedImageView.image = UIImage(named: "likedPosts")
        
        likedImageView.contentMode = .scaleAspectFill
        
        likedImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(likedImageView)
        
        NSLayoutConstraint.activate([
            likedImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            likedImageView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            likedImageView.heightAnchor.constraint(equalToConstant: 100),
            likedImageView.widthAnchor.constraint(equalToConstant: 100)
            
        ])
        
        animateLike(likedImageView, view)
        
    }
    
    func animateLike(_ likeImage: UIImageView , _ view: UIView) {
        
        likeImage.alpha = 0.0
        likeImage.transform = CGAffineTransform(scaleX: 1.7, y: 1.3)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            likeImage.alpha = 1
            likeImage.transform = .identity
        }) { _ in
            UIView.animate(withDuration: 0.2, animations: {
                likeImage.alpha = 0
                
                view.willRemoveSubview(likeImage)
            })
        }
    }
    
    func cellSetup(in cell: PostTableViewCell , in indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        
        cell.postImage.image = item.post.image
        cell.authorLabel.text = "\("source_key".localized) \(item.post.author)"
        cell.descriptionText.text = item.post.text
        cell.likesLabel.text = "\("likes_key".localized) \(String(describing: item.post.likes))"
        cell.viewsLabel.text = "\("views_key".localized) \(String(describing: item.post.views))"
        
        cell.userLabel.text = item.user.login
        cell.userPhoto.image = item.user.image
        
    }
    
}
