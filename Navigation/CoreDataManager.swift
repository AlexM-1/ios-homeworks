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


    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LikedPosts")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        container.viewContext.automaticallyMergesChangesFromParent = true

        return container
    }()


    // MARK: - Core Data Saving support

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


    func addPost(author: String, description: String, image: UIImage, likes: Int, views: Int) {

        persistentContainer.performBackgroundTask { context in

            guard self.isUniquePost(byText: description, context: context) else {return}

            let newPost = Post(context: context)
            newPost.author = author
            newPost.text = description
            newPost.image = image.pngData()
            newPost.likes = Int16(likes)
            newPost.views = Int16(views)
            newPost.created_at = Date()

            do {
                try context.save()
            } catch {
                print(error)
            }
        }

    }

    func deletePost(post: Post) {
        persistentContainer.viewContext.delete(post)
        saveContext()
    }



    private func isUniquePost(byText text: String, context: NSManagedObjectContext) -> Bool {
        let request = Post.fetchRequest()
        request.predicate = NSPredicate(format: "text == %@", text)
        if let _ = (try? context.fetch(request))?.first {
            return false
        } else {
            return true
        }
    }

}
