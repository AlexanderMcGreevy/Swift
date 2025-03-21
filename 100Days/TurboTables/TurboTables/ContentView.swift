//
//  ContentView.swift
//  TurboTables
//
//  Created by Alexander McGreevy on 3/20/25.
//

import SwiftUI

struct ContentView: View {
    @State private var answers: [Int] = []
    @State private var guessed = ""
    @State private var questions: [String] = []
    @State private var num1 = 0
    @State private var score = 0
    @State private var table = ""
    @State private var highScore = 0
    @State private var gameOver = false
    @State private var difficulty = 12
    @State private var questionOrder: [Int] = []
    @State private var currentquestion = 0
    
    
    
    
    
    var body: some View {
        ZStack{
            Color.cyan.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Turbo Tables")
                    .font(.largeTitle).bold().padding().padding().background(Color.red).cornerRadius(10).padding()
                VStack{
                    if gameOver && difficulty>1 {
                        
                        Text("Score: \(score)")
                            .font(.title)
                        
                        
                        Text("\(questions[questionOrder[currentquestion]])")
                            .font(.title)
                            .padding()
                        TextField("Enter your answer", text: $guessed)
                            .padding()
                            .keyboardType(.numberPad)
                        Button("Submit") {
                            checkAns()
                            
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
                    
                    
                    
                }.padding().background(Color.white).cornerRadius(10).padding().animation(.easeIn, value: gameOver)
                Button("New Game") {
                    genTables()
                    gameOver.toggle()
                    for i in 0..<difficulty {
                        questionOrder.append(i)
                        questionOrder.shuffle()
                    }
                }.padding().background(Color.white).cornerRadius(10).padding()
            }
            
        }
        
    }
    func genTables() {
        questions.removeAll()
        answers.removeAll()
        guessed.removeAll()
        
        
        if table=="0" || table=="" {
            num1 = Int.random(in: 1...difficulty)
        }
        for i in 1...12 {
            num1=Int(table)!
            questions.append("\(num1) x \(i)")
            answers.append(i * num1)
            
        }
        
    }
    func checkAns() {
        if guessed==String(answers[currentquestion]) {
            score+=1
        }
        if score>highScore {
            highScore=score
        }
        currentquestion+=1
        if currentquestion==difficulty {
            gameOver.toggle()
            score=0
            currentquestion=0
            table = ""
        }
        
    }
}

#Preview {
    ContentView()
}
