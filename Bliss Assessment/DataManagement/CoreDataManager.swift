//
//  CoreDataManager.swift
//  Bliss Assessment
//
//  Created by nathalia karine on 03/12/2024.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "EmojiDataModel")
        persistentContainer.loadPersistentStores { _, error in
        }
    }
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    func salvarContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save emojis: \(error)")
            }
        }
    }
}
