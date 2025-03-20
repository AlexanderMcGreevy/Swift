//
//  ContentView.swift
//  TurboTables
//
//  Created by Alexander McGreevy on 3/20/25.
//

import SwiftUI

struct ContentView: View {
    @State private var answers = []
    @State private var guessed = ""
    @State private var display = ""
    @State private var num1 = 0
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
                        List(0..<questions.count) { i in
                            Text("\(questions[i])")
                            TextField("Enter your answer", text: $display)
                                .padding()
                                .keyboardType(.numberPad)
                        }

                        Text("What is \(num1) x \(display)?")
                            .font(.title)
                            .padding()
                        TextField("Enter your answer", text: $guessed)
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
                            genTables()
                            gameOver.toggle()
                        }
                    }
                    
                }.background(Color.white).cornerRadius(10).padding().animation(.easeIn, value: gameOver)
            }
            
        }
        
    }
    func genTables() {
        num1=Int(table)!
        if table=="0"{
            num1 = Int.random(in: 1...12)
        }
        for i in 1...12 {
            questions.append("\(num1) x \(i)")
            answers.append(i * num1)

        }
        
    }
}

#Preview {
    ContentView()
}
