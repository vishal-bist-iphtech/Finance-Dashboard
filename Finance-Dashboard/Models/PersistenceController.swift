//
//  PersistenceController.swift
//  Finance-Dashboard
//
//  Created by iPHTech 34 on 10/07/26.
//

import CoreData

struct PersistenceController {

    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {

        container = NSPersistentContainer(name: "TransactionModel")

        container.loadPersistentStores { description, error in

            if let error = error {
                fatalError("Failed to load Core Data: \(error.localizedDescription)")
            }

        }

        container.viewContext.automaticallyMergesChangesFromParent = true

    }

}
