//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Alexander McGreevy on 2/27/25.
//

import SwiftUI

struct ContentView: View {
    @State private var useRedText = false
    
    var body: some View {
        Button("Hello World") {
            // flip the Boolean between true and false
            useRedText.toggle()
        }
        .foregroundStyle(useRedText ? .red : .blue)
        .padding()
        .background(useRedText ? .blue : .red)
        
        VStack {
            Text("Gryffindor").font(.largeTitle).blur(radius: 0)
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
        }
        .font(.title).blur(radius: 5)
    }
    
}

#Preview {
    ContentView()
}
