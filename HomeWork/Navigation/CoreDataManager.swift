//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Слава Орлов on 22.05.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistendContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "LikedPosts")
        container.loadPersistentStores { storeDescription, error in
            
            if let error = error as NSError? {
                return
            }
        }
        
        return container
    }()
    
    func savePost(post: Post) {
                
        let likedPost = LikedPost(context: persistendContainer.viewContext)
        
        likedPost.author = post.author
        likedPost.image = post.image
        likedPost.likes = Int64(post.likes)
        likedPost.text = post.text
        likedPost.views = Int64(post.views)
                
        try? persistendContainer.viewContext.save()
                
    }
    
    func fetchPost() -> [LikedPost] {
        
        let request = LikedPost.fetchRequest()
        
        return (try? persistendContainer.viewContext.fetch(request)) ?? []
        
    }
    
}
