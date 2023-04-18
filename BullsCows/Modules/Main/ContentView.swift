//
//  ContentView.swift
//  BullsCows
//
//  Created by Yaroslav Abaturov on 17.04.2023.
//

import SwiftUI

struct ContentView: View {
    #warning("test section")
    private let testData = Array(repeating: "1234", count: 20)
    #warning("test section")
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter a guess…", text: .constant("1234"))
                Button("Go", action: submitGuess)
            }
            .padding()
//            .frame(width: Constants.frame.width)
//            .frame(height: Constants.frame.height)
            List(testData, id: \.self) { guess in
                HStack {
                    Text(guess)
                    Spacer()
                    Text("4c 9b")
                }
            }
            .padding(10)
        }
    }
    
    private func submitGuess() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    private struct Constants {
        static let frame: (width: CGFloat, height: CGFloat) = (width: 250.0, height: 300.0)
    }
}
