import Foundation
import CoreData

// Singleton class to manage the Core Data stack
class CoreDataStack {
    static let shared = CoreDataStack() // Singleton instance

    // Persistent container for the Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PlantDataModel")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    // Context for interacting with Core Data
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // Save changes to the context
    func saveContext() {
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
}

