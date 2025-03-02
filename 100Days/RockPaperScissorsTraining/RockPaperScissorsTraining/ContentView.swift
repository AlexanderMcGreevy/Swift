import SwiftUI

struct ContentView: View {
    @State private var hands = ["Rock", "Paper", "Scissors"]
    @State private var handPressed = 0
    @State private var correctHand = 0
    @State private var score = 0
    @State private var highScore = 0
    @State private var showingScore = false
    @State private var time = 0
    @State private var timer: Timer?
    @State private var running = false
    @State private var condition = true
    
    
    var body: some View {
        ZStack {
            VStack{
                Text("Rock, Paper, Scissors")
                    .font(.title)
                Text("High Score: \(highScore)")
                Text("Time: \(time)")
                    .padding()
                Text(condition ? "Win" : "Lose")
                    .foregroundColor(condition ? .green : .red)
                    .font(.title.bold())
                    .padding()
                

                
                HStack{
                    ForEach(0..<3, id: \.self) { number in
                        Button {
                            handTapped(number)
                            handPressed=number
                            startCountdown()
                        } label: {
                            HandsView(hands: hands, number: number, handPressed: handPressed)
                            
                        }
                    }
                
                }
                .padding()
                Text("Score: \(score)")
                
            }
            
        }
    }
    func beatHand() {
        correctHand = Int.random(in: 0..<3)
        
    }
    
    func startCountdown() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            time += 1
        }
    }
    
    func handTapped(_ number: Int) {
        if handPressed == correctHand {
            //startCountdown()
            let tap = UIImpactFeedbackGenerator(style: .soft)
            tap.impactOccurred()
            score+=1
            time+=1
            
            
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
            HStack {
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
}

#Preview {
    ContentView()
}
