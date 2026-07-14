//
//  AddSavingsView.swift
//  Finance-Dashboard
//
//  Created by iPHTech 7 on 08/07/26.
//

import SwiftUI

struct AddSavingsGoalView: View {
    @ObservedObject var transactionViewModel: TransactionViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var amount = ""
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter Amount", text: $amount)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Savings Goal")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { presentationMode.wrappedValue.dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        if let value = Double(amount) {
                            transactionViewModel.updateSavingsGoal(value)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .disabled(amount.isEmpty)
                }
            }
        }
    }
}

#Preview {
        AddSavingsGoalView(transactionViewModel: TransactionViewModel(
            context: PersistenceController.shared.container.viewContext)
        )
}
