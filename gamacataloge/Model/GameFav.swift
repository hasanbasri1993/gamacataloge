//
//  GamesFav.swift
//  gamacataloge
//
//  Created by Hasan Basri on 29/08/20.
//  Copyright © 2020 Hasan Basri. All rights reserved.
//

import CoreData

class GameFav {

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GamesFavorite")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                // You should add your own error handling code here.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // The context couldn't be saved.
                // You should add your own error handling here.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil

        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }


    func getAllGamesFav(completion: @escaping (_ games: [Games]) -> ()) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GamesFav")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var games: [Games] = []
                for result in results {
                    let game = Games(
                            id: Int(result.value(forKeyPath: "id") as? Int16 ?? 1),
                            name: result.value(forKeyPath: "name") as? String ?? "  ",
                            background_image: (result.value(forKey: "background_image") as? String),
                            released: (result.value(forKey: "released") as? String),
                            rating: (result.value(forKey: "rating") as? Float),
                            genres: [Genres(id: 0, name: "", slug: "")])

                    games.append(game)
                }
                completion(games)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }

    func isFav(_ id: Int, completion: @escaping (Bool) -> ()) {
        let taskContext = newTaskContext()

        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GamesFav")
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                let results = try taskContext.fetch(fetchRequest)
                completion(results.count > 0 ? true : false)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }

    func setGamesFav(_ id: Int, _ name: String, _ background_image: String, _ released: String, _ rating: Float, completion: @escaping () -> ()) {
        let taskContext = newTaskContext()
        self.isFav(id) { (result) in
            DispatchQueue.main.async {
                if result {
                    taskContext.perform {
                        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GamesFav")
                        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
                        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                        batchDeleteRequest.resultType = .resultTypeCount
                        if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult,
                           batchDeleteResult.result != nil {
                            completion()
                        }
                    }
                } else {
                    taskContext.performAndWait {
                        if let entity = NSEntityDescription.entity(forEntityName: "GamesFav", in: taskContext) {
                            let game = NSManagedObject(entity: entity, insertInto: taskContext)
                            game.setValue(id, forKeyPath: "id")
                            game.setValue(name, forKeyPath: "name")
                            game.setValue(background_image, forKeyPath: "background_image")
                            game.setValue(released, forKeyPath: "released")
                            game.setValue(rating, forKeyPath: "rating")

                            do {
                                try taskContext.save()
                                completion()
                            } catch let error as NSError {
                                print("Could not save. \(error), \(error.userInfo)")
                            }

                        }
                    }
                }
            }
        }


    }


}
