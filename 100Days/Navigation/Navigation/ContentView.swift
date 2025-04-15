//
//  ContentView.swift
//  Navigation
//
//  Created by Alexander McGreevy on 4/11/25.
//

import SwiftUI


struct ContentView: View {
    @State private var title = "SwiftUI"

    var body: some View {
        NavigationStack {
            Text("Hello, world!")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    ContentView()
}
