//
//  EditTransactionView.swift
//  Finance-Dashboard
//
//  Created by iPHTech 34 on 13/07/26.
//

import SwiftUI

struct EditTransactionView: View {

    @ObservedObject var transactionViewModel: TransactionViewModel

    @Environment(\.dismiss) private var dismiss

    let transaction: Transaction

    @State private var title = ""
    @State private var amount = ""
    @State private var category: Category = .food
    @State private var isIncome = false
    
    
    private func loadTransaction() {

        title = transaction.title
        amount = String(transaction.amount)
        category = transaction.category
        isIncome = transaction.isIncome

    }
    
    private func saveChanges() {

        guard let amount = Double(amount) else {
            return
        }

        transactionViewModel.updateTransaction(
            transaction,
            title: title,
            amount: amount,
            category: category,
            isIncome: isIncome
        )

        dismiss()
    }

    var body: some View {
        

        NavigationStack {

            Form {

                Section("Transaction") {

                    TextField("Title", text: $title)

                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)

                    Picker("Category", selection: $category) {

                        ForEach(Category.allCases, id: \.self) { category in
                            Text(category.rawValue.capitalized)
                                .tag(category)
                        }
                    }

                    Toggle("Income", isOn: $isIncome)

                }

            }
            .navigationTitle("Edit Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                ToolbarItem(placement: .cancellationAction) {

                    Button("Cancel") {
                        dismiss()
                    }

                }

                ToolbarItem(placement: .confirmationAction) {

                    Button("Save") {

                        saveChanges()

                    }
                    .disabled(title.isEmpty || amount.isEmpty)

                }

            }
            .onAppear {

                loadTransaction()

            }

        }

    }
}



#Preview {
    EditTransactionView(transactionViewModel: TransactionViewModel(
        context: PersistenceController.shared.container.viewContext
    ),transaction: Transaction(
        id: UUID(),
        title: "Groceries",
        amount: 2500,
        category: .food,
        isIncome: false,
        date: Date()
    ))
}
