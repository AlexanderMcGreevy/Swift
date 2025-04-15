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
                        ForEach(habitList.habits) { habit in
                            HStack{
                                Text(habit.name)
                                Button {
                                   // count += 1
                                } label: {
                                    Label("Complete", systemImage: "checkmark.circle")
                                }
                                .buttonStyle(.borderedProminent).foregroundColor(.white)

                            }
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding()
                                .cornerRadius(10)
                            
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
    var date: Date
}

// Observable class that holds multiple activities
class HabitList: ObservableObject {
    @Published var habits: [Habit] = []
    
    
    
    
}


#Preview {
    ContentView()
}
