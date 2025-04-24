//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Alexander McGreevy on 4/24/25.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Student.self)
    }
}
