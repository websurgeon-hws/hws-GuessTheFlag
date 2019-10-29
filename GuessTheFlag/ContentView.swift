//
//  Copyright © 2019 Peter Barclay. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco",
        "Nigeria", "Poland", "Russia", "Spain", "UK", "US"
    ].shuffled()
        
    @State private var animateCorrect = [false, false, false]
    @State private var animateIncorrect = [false, false, false]
    @State private var animateNotSelected = [false, false, false]
    @State private var shouldAnimate = true

    @State private var correctAnswer = Int.random(in: 0 ... 2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag...")
                        .foregroundColor(.white)
                    Text("\(countries[correctAnswer])")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
              
                ForEach(0 ..< 3) { index in
                    Button(action: {
                        self.flagTapped(index)
                        
                    }) {
                        FlagImage(named: self.countries[index])
                    }
                    .rotation3DEffect(
                        .radians(self.animateCorrect[index] ? Double.pi * 2 : 0),
                        axis: (x: 0, y: 1, z: 0))
                    .animation(self.shouldAnimate ? .easeInOut(duration: 0.3) : nil)

                    .modifier(Shake(amount: self.shouldAnimate ? 10 : 0,
                                    animatableData: self.animateIncorrect[index] ? 1.0 : 0.0))

                    .opacity(self.animateNotSelected[index] ? 0.25 : 1.0)
                    .animation(self.shouldAnimate ? .easeInOut(duration: 0.3) : nil)
                }
                
                if score > 0 {
                    Text("Score: \(score)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),
                  message: Text(scoreMessage),
                  dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ index: Int) {
        animateResult(for: index)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.showResult(for: index)
        }
    }
    
    private func animateResult(for index: Int) {
        shouldAnimate = true

        self.animateCorrect[index] = index == correctAnswer
        self.animateIncorrect[index] = index != correctAnswer
        
        (0 ..< 3).forEach {
            self.animateNotSelected[$0] = $0 != index
        }
    }
    
    private func showResult(for index: Int) {
        if index == correctAnswer {
            score += 1
            askQuestion()
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "That’s the flag of \(countries[index])"
            showingScore = true
        }
    }
    
    private func resetAnimations() {
        shouldAnimate = false
        
        (0 ..< 3).forEach {
            self.animateCorrect[$0] = false
            self.animateIncorrect[$0] = false
            self.animateNotSelected[$0] = false
        }
    }
    
    func askQuestion() {
        resetAnimations()
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat = 1.0

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(self.animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

struct FlagImage: View {
    private let imageName: String

    init(named imageName: String) {
        self.imageName = imageName
    }
    
    var body: some View {
        Image(imageName)
        .renderingMode(.original)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(Color.black, lineWidth: 1))
        .shadow(radius: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
