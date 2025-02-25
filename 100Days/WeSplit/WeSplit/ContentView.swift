//
//  ContentView.swift
//  WeSplit
//
//  Created by Alexander McGreevy on 2/24/25.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    @State private var name = ""
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        NavigationStack {
                Form {
                    Section {
                        Text("Hello, world!")
                        
                        Button("Tap Count: \(tapCount)") {
                            self.tapCount += 1
                                }
                        TextField("Enter your name", text: $name)//$ means 2 way binding(When I change the var, it is immediately written in textbox below)
                        Form {
                            Picker("Select your student", selection: $selectedStudent) {
                                ForEach(students, id: \.self) {
                                    Text($0)
                                }
                            }
                        }
                    }
                    Text("Your name is \(name)")//name is only read, not written(no $)
                    
                }
            .navigationTitle("SwiftUI")
            .navigationBarTitleDisplayMode(.inline)
            }
    
    }
    
}

#Preview {
    ContentView()
}
