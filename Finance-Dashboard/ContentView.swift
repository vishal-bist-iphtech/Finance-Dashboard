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
    
    @AppStorage("isDarkMode")
    private var isDarkMode = false

    var body: some View {
        
        TabView {
            DashboardView(transactionViewModel: transactionViewModel)
                        .tabItem {
                            Label("Dashboard", systemImage: "house.fill")
                        }
                        .tag(0)

            TransactionsView(transactionViewModel: transactionViewModel)
                        .tabItem {
                            Label("Transactions", systemImage: "list.bullet")
                        }
                        .tag(1)
            InsightsView(transactionViewModel: transactionViewModel)
                        .tabItem {
                            Label("Insights", systemImage: "chart.pie")
                        }
                        .tag(2)
                
        }.preferredColorScheme(isDarkMode ? .dark : .light)
    }

}

#Preview {

        Group {
            ContentView(transactionViewModel: TransactionViewModel(
                context: PersistenceController.shared.container.viewContext
                )
            )

    }

}
