import SwiftUI

struct ContentView: View {
    @State private var hands = ["Rock", "Paper", "Scissors"]
    @State private var handPressed = 0
    @State private var correctHand = 0
    @State private var score = 0
    @State private var highScore = 0
    @State private var showingScore = false
    @State private var time = 60
    @State private var timer: Timer?
    @State private var running = false
    @State private var condition = true
    @State private var scoreTitle = ""
    @State private var current = ""
    @State private var correct = ""
    
    
    
    var body: some View {
        
        ZStack {
            VStack{
                
                Text("Rock, Paper, Scissors")
                    .font(.title)
                Text("High Score: \(highScore)")
                Text("Time: \(time)")
                    .padding()
                Image(current)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .opacity(1)
                Text(condition ? "Beat" : "Lose")
                    .foregroundColor(condition ? .green : .red)
                    .font(.title.bold())
                    .padding()
                

                
                HStack{
                    ForEach(0..<3, id: \.self) { number in
                        Button {
                            handTapped(number)
                            handPressed=number
                          
                        } label: {
                            HandsView(hands: hands, number: number, handPressed: handPressed)
                            
                        }
                    }
                
                }
                .padding()
                Text("Score: \(score)")
                Button("Start") {
                    score=0
                    genHand()
                    startCountdown()
                    time=60
                }.background(Color.red)
                
            }
            
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Try Again", action: genHand)
        } message: {
            Text("Score: \(score)")
        }
    }
    func genHand() {
        condition = Bool.random()
        let rand = Int.random(in: 0..<3)
        current = hands[rand]
        let win = ["Rock": "Scissors", "Paper": "Rock", "Scissors": "Paper"]
        let lose = ["Rock": "Paper", "Paper": "Scissors", "Scissors": "Rock"]
        
        if condition{
            correct = win[current]!
        } else {
            correct = lose[current]!
        }
        
        
    }
    

    
    func startCountdown() {
        timer?.invalidate()
        running = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            time -= 1
            if time == 0 {
                timer?.invalidate()
                running = false
                showingScore = true
                if score > highScore {
                    highScore = score
                }
                score = 0
            }
        }
    }

    
    func handTapped(_ number: Int) {
        if hands[number] == correct {
            //startCountdown()
            let tap = UIImpactFeedbackGenerator(style: .soft)
            tap.impactOccurred()
            score+=1
            genHand()
            
            
            
        } else {
            let impact = UIImpactFeedbackGenerator(style: .rigid)
            impact.impactOccurred()
            timer?.invalidate()
            running = false
            showingScore = true
            if score > highScore {
                highScore = score}
            score = 0
        }
        
    }
    struct HandsView: View {
        let hands: [String]
        let number: Int
        let handPressed: Int
        
        var body: some View {
            Image(hands[number])
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .opacity(1)
                .shadow(color: .black, radius: 6)
                .scaleEffect(handPressed == number ? 1.1 : 1.0)
                .animation(.spring(), value: handPressed)
                    
            
        }
    }
}

#Preview {
    ContentView()
}
