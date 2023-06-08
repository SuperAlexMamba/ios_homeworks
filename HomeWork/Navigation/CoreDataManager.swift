//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Слава Орлов on 22.05.2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
        
    private(set) var likedPosts: [LikedPost] = []
    
    private(set) var filteredPosts: [LikedPost] = []
    
    init() {
        fetchPost()
    }
    
    func savePost(post: Post) {
                        
        persistendContainer.performBackgroundTask { backgroundContext in
            
            let likedPost = LikedPost(context: backgroundContext)
            
            likedPost.author = post.author
            likedPost.image = post.image
            likedPost.likes = Int64(post.likes)
            likedPost.text = post.text
            likedPost.views = Int64(post.views)
            
            likedPost.managedObjectContext?.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            try? backgroundContext.save()
            self.fetchPost()
        }
    }
    
    func fetchPost() {
        
        let request = LikedPost.fetchRequest()
        
        likedPosts = (try? persistendContainer.viewContext.fetch(request)) ?? []
        
        filteredPosts = likedPosts

    }
    
    func deletePost(at index: Int) {
        
        persistendContainer.performBackgroundTask { [weak self] backgroundContext in
            guard let self = self else { return }
            let postForDelete = backgroundContext.object(with: self.likedPosts[index].objectID)
            backgroundContext.delete(postForDelete)
            try? backgroundContext.save()
        }
    }
    
    func searchPost(author: String) {
        
        filteredPosts = likedPosts.filter({$0.author?.contains(author) ?? false})
        
    }
    
    lazy var persistendContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "LikedPosts")
        container.loadPersistentStores { storeDescription, error in
            
            if let error = error as NSError? {
                return
            }
        }
        return container
    }()
}
