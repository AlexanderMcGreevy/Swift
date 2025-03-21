//
//  ContentView.swift
//  TurboTables
//
//  Created by Alexander McGreevy on 3/20/25.
//

import SwiftUI


struct ContentView: View {
    

        struct MovingImage: Identifiable {
            let id = UUID()
            var position: CGPoint
            var imageName: String
        }

        let availableImages = ["googly-a","googly-b","googly-c","googly-d","googly-e"]

    @State private var images: [MovingImage] = []

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
    @State private var scale = 1.0
    @State private var position: CGPoint = CGPoint(x: 100, y: 100)
    
    
    
    
    
    var body: some View {
        ZStack{
            Color.cyan.edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                        ZStack {
                            ForEach(images.indices, id: \.self) { index in
                                Image(systemName: images[index].imageName) // Uses unique image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .position(images[index].position)
                            }
                        }
                        .edgesIgnoringSafeArea(.all)
                        .onAppear {
                            setupImages(in: geometry.size)
                        }
                    }
                
            
            VStack {
                //Title
                Text("Turbo Tables")
                    .font(.largeTitle).bold().padding().padding().background(LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .leading, endPoint: .trailing)).cornerRadius(10).padding().clipShape(Capsule())
                    .scaleEffect(scale)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                            scale = 1.1
                        }
                    }

                VStack{
                    //Menu Toggle
                    if gameOver && difficulty>1 {
                        
                        Text("Score: \(score)")
                            .font(.title)
                        
                        //Question box
                        Text("\(questions[questionOrder[currentquestion]])")
                            .font(.title)
                            .padding()
                        TextField("Enter your answer", text: $guessed)
                            .padding()
                            .keyboardType(.numberPad)
                        Button("Submit") {
                            checkAns()
                            guessed = ""
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
                    
                    
                    //Menu
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
        
        
    }//Generate Times Tables
    func genTables() {
        questions.removeAll()
        answers.removeAll()
        guessed.removeAll()
        
        
        if table=="0" || table=="" {
            num1 = Int.random(in: 1...difficulty)
        }
        else{
            num1=Int(table)!
        }
        for i in 1...12 {
            questions.append("\(num1) x \(i)")
            answers.append(i * num1)
            
        }
        
    }
    func checkAns() {//Check answer and move to next question
        if guessed==String(answers[questionOrder[currentquestion]]) {
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
    func setupImages(in size: CGSize) {
            images = (1...5).map { _ in
                MovingImage(
                    position: CGPoint(x: CGFloat.random(in: 0...size.width), y: CGFloat.random(in: 0...size.height)),
                    imageName: availableImages.randomElement()! // Assign a random image
                )
            }

            // Start movement
            for index in images.indices {
                moveToRandomPosition(index: index, in: size)
            }
        }

        /// Move an image to a random position
        func moveToRandomPosition(index: Int, in size: CGSize) {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1.5...3)) {
                withAnimation(Animation.linear(duration: Double.random(in: 1.5...3)).repeatForever(autoreverses: false)) {
                    images[index].position = CGPoint(
                        x: CGFloat.random(in: 0...size.width),
                        y: CGFloat.random(in: 0...size.height)
                    )
                }
                moveToRandomPosition(index: index, in: size) // Keep moving
            }
        }
}

#Preview {
    ContentView()
}
