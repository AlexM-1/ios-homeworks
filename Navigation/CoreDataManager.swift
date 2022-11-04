//
//  LikedPostsManager.swift
//  Navigation
//
//  Created by Alex M on 23.10.2022.
//

import CoreData
import UIKit


class CoreDataManager {

    static let `default` = CoreDataManager()

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


    lazy var contextMain: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()


    lazy var contextBackground: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()

    // MARK: - Core Data Saving support


    func saveMainContext () {
        if contextMain.hasChanges {
            do {
                try contextMain.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error in main context \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func saveBackgroundContext () {
        if contextBackground.hasChanges {
            do {
                try contextBackground.save()

            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error in background context \(nserror), \(nserror.userInfo)")
            }
        }
    }

    var posts: [Post] = []

    func reloadPosts() {
        let request = Post.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "created_at", ascending: false)]
        do {
            self.posts = try contextMain.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }

    func addPost(author: String, description: String, imageName: String, likes: Int, views: Int) {

        var isUniquePost = true

        posts.forEach {
            if $0.text == description {
                isUniquePost = false }
        }
        guard isUniquePost else {return}

        let newPost = Post(context: contextBackground)

        newPost.author = author
        newPost.text = description
        if let image = UIImage(named: imageName) {
            newPost.image = image.pngData()
        }
        newPost.likes = Int16(likes)
        newPost.views = Int16(views)
        newPost.created_at = Date()
        saveBackgroundContext()
        reloadPosts()
    }

    func deletePost(post: Post) {
        contextMain.delete(post)
        saveMainContext()
        reloadPosts()
    }


    func searchPost(_ author:  String) -> [Post] {
        let request = Post.fetchRequest()
        request.predicate = NSPredicate(format: "author contains[c] %@", author)
        return (try? contextMain.fetch(request)) ?? []
    }

}
