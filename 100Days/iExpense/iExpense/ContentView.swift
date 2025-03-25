//
//  ContentView.swift
//  iExpense
//
//  Created by Alexander McGreevy on 3/24/25.
//

import SwiftUI
import Observation


struct ContentView: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }.sheet(isPresented: $showingSheet) {
            SecondView(name: "@twostraws")
        }

    }
}
struct SecondView: View {
    @Environment(\.dismiss) var dismiss

    let name: String

       var body: some View {
           Text("Hello, \(name)!")
           Button("Dismiss") {
               dismiss()
           }
       }
}


#Preview {
    ContentView()
}

