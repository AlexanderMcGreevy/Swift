//
//  ContentView.swift
//  Moonshot
//
//  Created by Alexander McGreevy on 3/27/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let layout = [
            GridItem(.adaptive(minimum: 80, maximum: 120)),
        ]
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
