//
//  ContentView.swift
//  TurboTables
//
//  Created by Alexander McGreevy on 3/20/25.
//

import SwiftUI

struct ContentView: View {
    @State private var answer = 0
    @State private var guessed = 0
    @State private var display = ""
    @State private var num1 = 0
    @State private var num2 = 0
    @State private var score = 0
    @State private var table = ""
    @State private var highScore = 0
    @State private var questions = []
    @State private var gameOver = false


    var body: some View {
        ZStack{
            Color.cyan.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Turbo Tables")
                    .font(.largeTitle).bold().padding().padding().background(Color.red).cornerRadius(10)
                VStack{
                    if gameOver {
                        Text("Score: \(score)")
                            .font(.title)

                        Text("What is \(num1) x \(num2)?")
                            .font(.title)
                            .padding()
                        TextField("Enter your answer", text: $display)
                            .padding()
                            .keyboardType(.numberPad)
                        Button("Submit") {
                            //checkAnswer()
                        }
                    } else {
                        Text("High Score: \(highScore)")
                            .font(.title)
                            .padding()
                        Text("Choose a table to practice!:")
                            .font(.headline)
                        TextField("Enter 0 for Random", text: $table)
                            .keyboardType(.numberPad)
                        
        
                        Button("New Game") {
                            gameOver.toggle()
                        }
                    }
                    
                }.background(Color.white).cornerRadius(10).padding().animation(.easeIn, value: gameOver)
            }
            
        }
        
    }
    func selectTable() {
        num2 = Int.random(in: 1...12)
        
    }
}

#Preview {
    ContentView()
}
