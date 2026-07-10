//
//  Finance_DashboardApp.swift
//  Finance-Dashboard
//
//  Created by iPHTech 7 on 07/07/26.
//

import SwiftUI
import CoreData

@main
struct Finance_DashboardApp: App {
    
    let presistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                transactionViewModel: TransactionViewModel(
                    context: presistenceController.container.viewContext
                )
            )
                .environment(
                    \.managedObjectContext,
                     presistenceController.container.viewContext
                )
        }
    }
}
