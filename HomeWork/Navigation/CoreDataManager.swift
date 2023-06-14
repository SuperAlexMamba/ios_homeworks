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
        
    var likedPosts: [LikedPost] = []
    
    lazy var persistendContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "LikedPosts")
        container.loadPersistentStores { storeDescription, error in
            
            if let error = error as NSError? {
                return
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()
    
    
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
        }
    }
        
    func deletePost(post: LikedPost) {
        
        persistendContainer.performBackgroundTask { [weak self] backgroundContext in
            guard let self = self else { return }
            let postForDelete = backgroundContext.object(with: post.objectID)
            backgroundContext.delete(postForDelete)
            try? backgroundContext.save()
        }
    }
}
