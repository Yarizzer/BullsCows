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
        VStack(spacing: 0.0) {
            HStack {
                TextField("Enter a guess…", text: $userInputGuess)
                Button("Go", action: submitGuess)
            }
            .padding(10)
            List(guesses, id: \.self) { guess in
                HStack {
                    Text(guess)
                    Spacer()
                    Text(result(for: guess))
                }
            }
            .padding(10)
        }
        .frame(width: Constants.frame.width)
        .frame(height: Constants.frame.height)
        .onAppear(perform: startNewGame)
        .alert("You win!", isPresented: $isGameOver) {
            Button("OK", action: startNewGame)
        } message: {
            Text("Congratulations! Click OK to play again.")
        }
    }
    
    private func submitGuess() {
//        guesses.append(userInputGuess)
//        userInputGuess = ""
        
        guard Set(userInputGuess).count == answerLength else { return }
        guard userInputGuess.count == answerLength else { return }

        let badCharacters = CharacterSet(charactersIn: "0123456789").inverted
        guard userInputGuess.rangeOfCharacter(from: badCharacters) == nil else { return }

        guesses.insert(userInputGuess, at: 0)

        if result(for: userInputGuess).contains("\(answerLength)b") {
            isGameOver = true
        }

        // clear their guess string
        userInputGuess = ""
    }
    
    private func result(for guess: String) -> String {
        var bulls = 0
        var cows = 0

        let guessLetters = Array(guess)
        let answerLetters = Array(answer)

        for (index, letter) in guessLetters.enumerated() {
            if letter == answerLetters[index] {
                bulls += 1
            } else if answerLetters.contains(letter) {
                cows += 1
            }
        }

        return "\(bulls)b \(cows)c"
    }
    
    private func startNewGame() {
        userInputGuess = ""
        guesses.removeAll()
        answer = ""
        
        let numbers = (0...9).shuffled()
        
        for i in 0..<answerLength {
            answer.append(String(numbers[i]))
        }
    }
    
    @State private var userInputGuess = ""
    @State private var guesses = [String]()
    @State private var answer = ""
    @State private var isGameOver = false
    private let answerLength = 4
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
