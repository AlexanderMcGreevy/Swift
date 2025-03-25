//
//  ContentView.swift
//  iExpense
//
//  Created by Alexander McGreevy on 3/24/25.
//

import SwiftUI
import Observation


struct ContentView: View {
    @State private var expenses = Expenses()

    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }.toolbar {
                Button("Add Expense", systemImage: "plus") {
                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                    expenses.items.append(expense)
                }
            }
            .navigationTitle("iExpense")
        }

    }
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
}
@Observable
class Expenses {
    var items = [ExpenseItem]()
}

struct ExpenseItem: Identifiable {
    let id = UUID()//Univeersal unique ID
    let name: String
    let type: String
    let amount: Double
}

#Preview {
    ContentView()
}

