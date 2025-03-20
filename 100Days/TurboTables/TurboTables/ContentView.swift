//
//  ContentView.swift
//  TurboTables
//
//  Created by Alexander McGreevy on 3/20/25.
//

import SwiftUI

struct ContentView: View {
    @State private var answers = []
    @State private var guessed = [String]
    @State private var num1 = 0
    @State private var score = 0
    @State private var table = ""
    @State private var highScore = 0
    @State private var questions = []
    @State private var gameOver = false
    @State private var difficulty = 12
    
    
    
    
    var body: some View {
        ZStack{
            Color.cyan.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Turbo Tables")
                    .font(.largeTitle).bold().padding().padding().background(Color.red).cornerRadius(10)
                VStack{
                    if gameOver && difficulty>1 {
                        
                        Text("Score: \(score)")
                            .font(.title)
                        List{
                            ForEach(questions.indices.shuffled(), id: \.self) { i in
                                
                                Text("\(questions[i])")
                                TextField("Enter your answer", text: $guessed)
                                    .padding()
                                    .keyboardType(.numberPad)
                            }
                        }
                        
                        
                        
                    } else {
                        Text("High Score: \(highScore)")
                            .font(.title)
                            .padding()
                        Text("Choose a times table to practice!:")
                            .font(.headline)
                        TextField("Enter 0 for Random", text: $table)
                            .keyboardType(.numberPad)
                    }
                    
                    
                    Button("New Game") {
                        genTables()
                        gameOver.toggle()
                    }
                }.background(Color.white).cornerRadius(10).padding().animation(.easeIn, value: gameOver)
            }
            
        }
        
    }
    func genTables() {
        num1=Int(table)!
        if table=="0"{
            num1 = Int.random(in: 1...difficulty)
        }
        for i in 1...12 {
            questions.append("\(num1) x \(i)")
            answers.append(i * num1)
            
        }
        
    }
    func checkAns(){
        for i in questions.indices{
            if Int(guessed[i]) == answers[i] {
                score+=1
            }
        }
    }
}

#Preview {
    ContentView()
}
