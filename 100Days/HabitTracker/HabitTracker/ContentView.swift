//
//  ContentView.swift
//  HabitTracker
//
//  Created by Alexander McGreevy on 4/15/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var habitList = HabitList()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.yellow)
                    .ignoresSafeArea()
                VStack {
                    Text("Habit Tracker")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .shadow(radius: 3)
                    
                    List {
                        ForEach(Array(habitList.habits.enumerated()), id: \.element.id) { index, habit in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(habit.name)
                                        .font(.headline)
                                    Text(habit.description)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Text("Completed: \(habit.count) times")
                                        .font(.caption)
                                }
                                Spacer()
                                Button {
                                    habitList.habits[index].count += 1
                                } label: {
                                    Label("Complete", systemImage: "checkmark.circle")
                                }
                                .buttonStyle(.borderedProminent)
                            }
                            .padding()
                        }
                    }.padding().cornerRadius(10).opacity(0.8)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(.yellow)
            .preferredColorScheme(.light)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Add Activity", destination: ActivityAdd(habitList: habitList))
                        .font(.headline)
                        .padding(10)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
            }
        }
    }
}


// Struct to hold a single activity
struct Habit: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var count: Int = 0
}


// Observable class that holds multiple activities
class HabitList: ObservableObject {
    @Published var habits: [Habit] = []
    
    
    
    
}


#Preview {
    ContentView()
}
