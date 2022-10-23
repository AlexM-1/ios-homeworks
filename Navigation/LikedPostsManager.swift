//
//  LikedPostsManager.swift
//  Navigation
//
//  Created by Alex M on 23.10.2022.
//

import CoreData
import UIKit


class LikedPostsManager {

    static let `default` = LikedPostsManager()

    private init() {
        reloadPosts()
    }


    // MARK: - Core Data stack

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LikedPosts")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    var posts: [Post] = []

    func reloadPosts() {
        let request = Post.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "created_at", ascending: false)]
        do {
            self.posts = try persistentContainer.viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }

    func addPost(author: String, description: String, imageName: String, likes: Int, views: Int) {

        let newPost = Post(context: persistentContainer.viewContext)

        newPost.author = author
        newPost.text = description
        if let image = UIImage(named: imageName) {
            newPost.image = image.pngData()
        }
        newPost.likes = Int16(likes)
        newPost.views = Int16(views)
        newPost.created_at = Date()
        saveContext()
        reloadPosts()
    }

    func deletePost(post: Post) {
        persistentContainer.viewContext.delete(post)
        saveContext()
        reloadPosts()
    }

}
