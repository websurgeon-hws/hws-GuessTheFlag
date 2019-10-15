//
//  Copyright © 2019 Peter Barclay. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                Text("1")
                Text("2")
                Text("3")
            }
            HStack(spacing: 20) {
                Text("4")
                Text("5")
                Text("6")
            }
            HStack(spacing: 20) {
                Text("7")
                Text("8")
                Text("9")
            }
        }.font(.system(size: 32))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
