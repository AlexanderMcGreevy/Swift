//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Alexander McGreevy on 2/26/25.
//

import SwiftUI

struct ContentView: View {
    //Var space
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var flagPressed = 0

    
    var body: some View {
            ZStack{
                AngularGradient(colors: [.red, .black, .indigo, .indigo, .black, .red], center: UnitPoint(x: 0.5, y: 0.55))
                    .ignoresSafeArea()
                
                VStack {
                    Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                        .padding()
                          

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
                                Image(countries[number]).clipShape(RoundedRectangle(cornerRadius: 20)).shadow(color: .black, radius: 6)

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
                Button("Continue", action: askQuestion)
            } message: {
                Text("That's the flag of \(countries[flagPressed])!")
            }
            
        }
    //Function space
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            let tap = UIImpactFeedbackGenerator(style: .soft)
            tap.impactOccurred()
            score+=1

            askQuestion()
        } else {
            scoreTitle = "Wrong"
            let impact = UIImpactFeedbackGenerator(style: .rigid)
                impact.impactOccurred()
            showingScore = true
        }
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    }

        
    


#Preview {
    ContentView()
}
