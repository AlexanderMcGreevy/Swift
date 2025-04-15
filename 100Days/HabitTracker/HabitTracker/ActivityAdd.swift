//
//  ActivityView.swift
//  HabitTracker
//
//  Created by Alexander McGreevy on 4/15/25.
//

import SwiftUI

struct ActivityAdd: View {
    @ObservedObject var habitList: HabitList
    
    @State private var activity = ""
    @State private var description = ""
    @State private var count = 0

    var body: some View {
        ZStack {
            Color(.yellow)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                TextField("Enter activity", text: $activity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                TextField("Enter description", text: $description)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button("Add Activity") {
                    let newHabit = Habit(name: activity, date: Date())
                    habitList.habits.append(newHabit)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
            }
        }
        .navigationTitle("New Activity")
    }
}


#Preview {
    ActivityAdd(habitList: HabitList())
}
