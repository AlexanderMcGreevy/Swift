//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Alexander McGreevy on 2/26/25.
//

import SwiftUI

struct ContentView: View {
    //Var space
    @State var countries = ["Bhutan", "Brazil", "Cambodia", "Cuba", "Estonia", "France", "Germany", "Ireland", "Italy", "Jamaica", "Japan", "Kazakhstan", "Mexico", "Monaco", "Nigeria", "Poland", "The Soviet Union", "Spain", "Sri Lanka", "UK", "Ukraine", "US", "Vietnam", "Wales"].shuffled()

    @State var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var flagPressed = 0
    //TImer
    @State private var time = 60
    @State private var timer: Timer? = nil
    @State private var running = false
    //Saves High score
    @AppStorage("highScore") var highScore = 0
    
    
    var body: some View {
        ZStack{
            AngularGradient(colors: [.red, .black, .indigo, .indigo, .black, .red], center: UnitPoint(x: 0.5, y: 0.55))
                .ignoresSafeArea()
            
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                Text("High Score: \(highScore)")
                    .foregroundStyle(.white)
                    .font(.headline.bold())
                Text("Time Remaining: \(time)")
                    .foregroundStyle(.white)
                    .font(.headline.bold())
                
                
                
                
                
                
                VStack(spacing: 25) {
                    VStack {
                        Text("Tap the flag of").foregroundStyle(.white).font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer]).foregroundStyle(.white).font(.largeTitle.weight(.semibold))
                        
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            flagPressed=number
                        } label: {
                            Image(countries[number])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 100)
                                .opacity(1)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(color: .black, radius: 6)
                                .scaleEffect(flagPressed == number ? 1.1 : 1.0)
                                .animation(.spring(), value: flagPressed)


                            
                        }
                    }
                }.frame(maxWidth: 250)
                    .padding(.vertical, 15)
                    .background(Color.black.opacity(0.3))
                    .clipShape(.rect(cornerRadius: 20))
                    .padding()
                    .padding()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                    .padding()
                
            }
            
            
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Try Again", action: askQuestion)
        } message: {
            Text("That's the flag of \(countries[flagPressed])!")
        }
        
    }
    //Function space
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            startCountdown()
            let tap = UIImpactFeedbackGenerator(style: .soft)
            tap.impactOccurred()
            score+=1
            time+=1
            
            askQuestion()
        } else {
            scoreTitle = "YOU LOSE!"
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
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func startCountdown() {
        if running==false {
            running = true
            timer?.invalidate()
            time = 60
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                if time > 0 {
                    time -= 1
                } else {
                    timer.invalidate()
                    scoreTitle = "TIME'S UP!"
                    let impact = UIImpactFeedbackGenerator(style: .rigid)
                    impact.impactOccurred()
                    showingScore = true
                    if score > highScore {
                        highScore = score}
                    score = 0
                    running = false
                }
            }
        }
    }
}

        
    


#Preview {
    ContentView()
}
