//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Alexander McGreevy on 2/27/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Hello, world!") {
                print(type(of: self.body))
            }
            .frame(width: 200, height: 200).background(.red)
            
        }
        

    }
}

#Preview {
    ContentView()
}
