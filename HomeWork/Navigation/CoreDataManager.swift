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
    
    func savePost(post: [Post], at indexPath: Int) {
                
        let likedPost = LikedPost(context: persistendContainer.viewContext)
        
        likedPost.author = post[indexPath].author
        likedPost.image = post[indexPath].image
        likedPost.likes = Int64(post[indexPath].likes)
        likedPost.text = post[indexPath].text
        likedPost.views = Int64(post[indexPath].views)
                
        try? persistendContainer.viewContext.save()
                
    }
    
    func fetchPost() -> [LikedPost] {
        
        let request = LikedPost.fetchRequest()
        
        return (try? persistendContainer.viewContext.fetch(request)) ?? []
        
    }
    
}
