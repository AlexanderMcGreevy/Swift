import SwiftUI

struct ContentView: View {
    @State var countries = ["Bhutan", "Brazil", "Cambodia", "Cuba", "Estonia", "France", "Germany", "Ireland", "Italy", "Jamaica", "Japan", "Kazakhstan", "Mexico", "Monaco", "Nigeria", "Poland", "Soviet Union", "Spain", "Sri Lanka", "UK", "Ukraine", "US", "Vietnam", "Wales"].shuffled()

    @State var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var flagPressed = 0

    // Timer
    @State private var time = 60
    @State private var timer: Timer? = nil
    @State private var running = false

    // High Score
    @AppStorage("highScore") var highScore = 0

    // Animation
    @State private var correctFlagRotation = 0.0
    @State private var flagSelected = false
    @State private var hasAnswered = false
    
    var body: some View {
        ZStack {
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
                    .foregroundStyle((time <= 30) && (time % 2 == 0) ? .red : .white)
                    .font(.headline.bold()).animation(.spring(duration: 0.5), value: time)

                VStack(spacing: 25) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.white)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(countries: countries, number: number, flagPressed: flagPressed)
                        }
                        .rotation3DEffect(.degrees((hasAnswered && number == correctAnswer) ? correctFlagRotation : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(flagSelected && number != correctAnswer ? 0.3 : 1.0)
                        .animation(.easeInOut(duration: 0.5), value: flagSelected)
                        .padding()
                    }
                }
                .frame(maxWidth: 250)
                .padding(.vertical, 15)
                .background(Color.black.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()

                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                    .padding()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Try Again", action: askQuestion)
        } message: {
            Text("That's the flag of \(countries[flagPressed])!")
        }
    }

    // Function to handle flag tapping
    func flagTapped(_ number: Int) {
        flagPressed = number
        flagSelected = true
        hasAnswered = true

        if number == correctAnswer {
            startCountdown()
            let tap = UIImpactFeedbackGenerator(style: .soft)
            tap.impactOccurred()
            score += 1
            time += 1

            withAnimation {
                correctFlagRotation += 360
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                askQuestion()
            }
        } else {
            scoreTitle = "YOU LOSE!"
            let impact = UIImpactFeedbackGenerator(style: .rigid)
            impact.impactOccurred()
            timer?.invalidate()
            running = false
            showingScore = true

            if score > highScore {
                highScore = score
            }
            score = 0
        }
    }

    // Resets the game
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        flagSelected = false
        hasAnswered = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {  // ⏳ Small delay before reset
            correctFlagRotation = 0.0
        }
    }

    func startCountdown() {
        if !running {
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
                        highScore = score
                    }
                    score = 0
                    running = false
                }
            }
        }
    }
}

struct FlagImage: View {
    let countries: [String]
    let number: Int
    let flagPressed: Int

    var body: some View {
        Image(countries[number])
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black, radius: 6)
            .scaleEffect(flagPressed == number ? 1.1 : 1.0)
            .animation(.spring(), value: flagPressed)
    }
}

#Preview {
    ContentView()
}
