//
//  AddSavingsView.swift
//  Finance-Dashboard
//
//  Created by iPHTech 7 on 08/07/26.
//

import SwiftUI

struct AddSavingsView: View {
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
                            transactionViewModel.savings = value
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .disabled(amount.isEmpty)
                }
            }
        }
    }
}

struct AddSavingsView_Previews: PreviewProvider {
    static var previews: some View {
        AddSavingsView(transactionViewModel: TransactionViewModel(
            context: PersistenceController.shared.container.viewContext
        )
        )
    }
}
