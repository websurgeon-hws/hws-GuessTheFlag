//
//  Copyright © 2019 Peter Barclay. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 30
        ) {
            Button("Tap me 1!") {
                print("Button was tapped")
            }
            Button(action: {
                print("Button was tapped")
            }) {
                Text("Tap me 2!")
            }
            Button(action: {
                print("Edit button was tapped")
            }) {
                Image(systemName: "pencil")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
