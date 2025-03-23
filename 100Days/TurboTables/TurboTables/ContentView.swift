import SwiftUI

struct ContentView: View {
    
    class MovingImagesManager: ObservableObject {
        struct MovingImage: Identifiable {
            let id = UUID()
            var position: CGPoint
            var imageName: String
        }

        let availableImages = ["googly-a", "googly-b", "googly-c", "googly-d", "googly-e"]
        
        @Published var images: [MovingImage] = []

        func setupImages(in size: CGSize) {
            images = (1...5).map { _ in
                MovingImage(
                    position: CGPoint(x: CGFloat.random(in: -100...size.width),
                                      y: CGFloat.random(in: -300...size.height)),
                    imageName: availableImages.randomElement()!
                )
            }

            for index in images.indices {
                moveToRandomPosition(index: index, in: size)
            }
        }

        func moveToRandomPosition(index: Int, in size: CGSize) {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1.5...3)) {
                withAnimation(Animation.linear(duration: Double.random(in: 1.5...5)).repeatForever(autoreverses: true)) {
                    self.images[index].position = CGPoint(
                        x: CGFloat.random(in: -100...size.width),
                        y: CGFloat.random(in: -300...size.height)
                    )
                    
                }
                self.moveToRandomPosition(index: index, in: size)
            }
        }
    }

    @StateObject private var imagesManager = MovingImagesManager()
    @State private var scale = 1.0
    @State private var gameOver = false
    @State private var difficulty = 12
    @State private var score = 0
    @State private var highScore = 0
    @State private var guessed = ""
    @State private var num1 = 0
    @State private var questions: [String] = []
    @State private var answers: [Int] = []
    @State private var questionOrder: [Int] = []
    @State private var currentQuestion = 0

    var body: some View {
        ZStack {
            Color.cyan.edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                ZStack {
                    ForEach(imagesManager.images.indices, id: \.self) { index in
                        Image(imagesManager.images[index].imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .position(imagesManager.images[index].position)
                    }
                }
                .onAppear {
                    imagesManager.setupImages(in: geometry.size)
                }
            }
            
            VStack {
                Text("Turbo Tables")
                    .font(.largeTitle).bold()
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [.red, .orange]),
                                               startPoint: .leading,
                                               endPoint: .trailing))
                    .cornerRadius(10)
                    .clipShape(Capsule())
                    .scaleEffect(scale)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                            scale = 1.1
                        }
                    }
                
                VStack {
                    if gameOver && difficulty > 1 {
                        Text("Score: \(score)").font(.title)
                        Text("\(questions[questionOrder[currentQuestion]])")
                            .font(.title)
                            .padding()
                        
                        TextField("Enter your answer", text: $guessed)
                            .padding()
                            .keyboardType(.numberPad)
                        
                        Button("Submit") {
                            checkAnswer()
                            guessed = ""
                        }
                    } else {
                        Text("High Score: \(highScore)").font(.title).padding()
                        Text("Choose a times table to practice!").font(.headline)
                        
                        Stepper(value: $num1, in: 0...12) {
                            if num1 == 0 {
                                Text("Times Table: Random")
                            } else {
                                Text("Times Table: \(num1)")
                            }
                        }
                        
                        Picker("Difficulty Level:", selection: $difficulty) {
                            ForEach(1...100, id: \.self) { amount in
                                Text("Multiples up to \(amount)")
                            }
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .animation(.easeIn, value: gameOver)
                
                Button("New Game") {
                    startNewGame()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
            }
        }
    }

    func startNewGame() {
        generateQuestions()
        gameOver.toggle()
        questionOrder = (0..<difficulty).shuffled()
    }

    func generateQuestions() {
        questions.removeAll()
        answers.removeAll()
        
        if num1==0{
            num1 = Int.random(in: 1...12)
        }
        
        for i in 1...difficulty {
            questions.append("\(num1) x \(i)")
            answers.append(i * num1)
        }
    }

    func checkAnswer() {
        if guessed == String(answers[questionOrder[currentQuestion]]) {
            score += 1
        }
        if score > highScore {
            highScore = score
        }
        currentQuestion += 1
        if currentQuestion == difficulty {
            gameOver.toggle()
            score = 0
            currentQuestion = 0
            num1 = 0
        }
    }
}

#Preview {
    ContentView()
}
