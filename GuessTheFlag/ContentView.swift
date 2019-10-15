//
//  Copyright © 2019 Peter Barclay. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private let countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco",
        "Nigeria", "Poland", "Russia", "Spain", "UK", "US"
    ]
    
    private var correctAnswer = Int.random(in: 0 ... 2)
    
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag...")
                    Text("\(countries[correctAnswer])")
                }.foregroundColor(.white)
              
                ForEach(0 ..< 3) { index in
                    Button(action: {
                        // flag was tapped
                    }) {
                        Image(self.countries[index])
                            .renderingMode(.original)
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
