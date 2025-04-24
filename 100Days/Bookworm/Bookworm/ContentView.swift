//
//  ContentView.swift
//  Bookworm
//
//  Created by Alexander McGreevy on 4/24/25.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @Query var students: [Student]
    @Environment(\.modelContext) var modelContext


    var body: some View {
        NavigationStack {
            List(students) { student in
                Text(student.name)
            }.toolbar {
                Button("Add") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                    let chosenFirstName = firstNames.randomElement()!
                    let chosenLastName = lastNames.randomElement()!

                    let student = Student(id: UUID(), name: "\(chosenFirstName) \(chosenLastName)")
                    modelContext.insert(student)

                }
            }
            .navigationTitle("Classroom")
        }
    }
}

@Model
class Student {
    var id: UUID
    var name: String

    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}

#Preview {
    ContentView().modelContainer(for: Student.self, inMemory: true)
}
