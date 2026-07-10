//
//  ContentView.swift
//  Finance-Dashboard
//
//  Created by iPHTech 7 on 07/07/26.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext)
    private var viewContext

    // TransactionViewModel initialized
    @ObservedObject var transactionViewModel: TransactionViewModel

    var body: some View {
        
        TabView {
            DashboardView(transactionViewModel: transactionViewModel)
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Dashboard")
                        }

            TransactionsView(transactionViewModel: transactionViewModel)
                        .tabItem {
                            Image(systemName: "list.bullet")
                            Text("Transactions")
                        }
                }
    }

}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {

        Group {
            ContentView(transactionViewModel: TransactionViewModel(
                context: PersistenceController.shared.container.viewContext
                )
            )
        }

    }

}
