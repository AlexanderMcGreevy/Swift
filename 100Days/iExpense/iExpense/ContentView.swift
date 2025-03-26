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
    @State private var showingAddExpense = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }

                        Spacer()
                        let localCurrencyCode = Locale.current.currency?.identifier ?? "USD"
                        Text(item.amount, format: .currency(code: localCurrencyCode))
                            .foregroundColor(item.amount < 10 ? .green : item.amount < 100 ? .orange : .red)
                            .font(item.amount < 10 ? .body : item.amount < 100 ? .title2 : .title)
                    }
                }
                .onDelete(perform: removeItems)
            }.toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }.sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
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
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()//Univeersal unique ID
    let name: String
    let type: String
    let amount: Double
}

#Preview {
    ContentView()
}

