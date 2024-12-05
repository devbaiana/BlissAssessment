//
//  PersistenceAvatarController.swift
//  Bliss Assessment
//
//  Created by nathalia karine on 05/12/2024.
//

import Foundation
import CoreData

struct PersistenceAvatarController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Erro ao carregar o armazenamento persistente: \(error), \(error.userInfo)")
            }
        }
    }
}
