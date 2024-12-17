//
//  gameView.swift
//  Memory Game
//
//  Created by Jonathan V on 12/9/24.
//

import SwiftUI

struct gameView: View {
    @State private var cards = [
        // create cards with image names and shuffle them
        Card(imageName: "image1"), Card(imageName: "image1"),
        Card(imageName: "image2"), Card(imageName: "image2"),
        Card(imageName: "image3"), Card(imageName: "image3"),
        Card(imageName: "image4"), Card(imageName: "image4"),
        Card(imageName: "image5"), Card(imageName: "image5"),
        Card(imageName: "image6"), Card(imageName: "image6"),
        Card(imageName: "image7"), Card(imageName: "image7"),
        Card(imageName: "image8"), Card(imageName: "image8")
    ].shuffled()
    
    @State private var selectedCards: [UUID] = []
    @State private var player1Score = 0
    @State private var player2Score = 0
    @State private var currentPlayer = 1
    @State private var showingEndGameAlert = false
    @State private var winnerMessage = ""
    @State private var attempts = 0 // Counter for attempts
    
    let columns = [
        // create grid layout
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Player \(currentPlayer)'s Turn")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .fontWeight(.heavy)
                
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(cards) { card in
                        CardView(card: card)
                            .onTapGesture {
                                withAnimation {
                                    tapCard(card)
                                }
                            }
                    }
                }
                .padding()
                
                HStack {
                    VStack {
                        Text("Player 1")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("Score: \(player1Score)")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .padding()
                    
                    VStack {
                        Text("Player 2")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("Score: \(player2Score)")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .padding()
                }
            }
        }
        .alert(isPresented: $showingEndGameAlert) {
            Alert(
                title: Text("Game Over"),
                message: Text(winnerMessage),
                dismissButton: .default(Text("New Game")) {
                    resetGame()
                }
            )
        }
    }
    // function to make tapping card on screen work
    func tapCard(_ card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }),
           !cards[index].isFaceUp, //makes sure card isnt already flipped
           !cards[index].isMatched, //makes sure that card doesnt already have a match
           selectedCards.count < 2 {
            
            cards[index].isFaceUp = true
            selectedCards.append(card.id)

            attempts += 1
            
            if selectedCards.count == 2 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    checkForMatch()
                }
            }
        }
    }
    
    func checkForMatch() { //checks value of card, and checks if the value of the two cards are the same
        let selectedCardIndices = cards.indices.filter { selectedCards.contains(cards[$0].id) }
        
        if cards[selectedCardIndices[0]].imageName == cards[selectedCardIndices[1]].imageName {
            cards[selectedCardIndices[0]].isMatched = true
            cards[selectedCardIndices[1]].isMatched = true
            
            if currentPlayer == 1 {
                player1Score += 1
            } else {
                player2Score += 1
            }

            // Check if all cards are matched
            if cards.allSatisfy({ $0.isMatched }) {
                endGame()
            }
        } else {
            cards[selectedCardIndices[0]].isFaceUp = false
            cards[selectedCardIndices[1]].isFaceUp = false
            
            currentPlayer = currentPlayer == 1 ? 2 : 1
        }
        
        selectedCards.removeAll()
    }
    
    // finishes game, checks to see who had more points and sends alert to show who wins
    func endGame() {
        if player1Score > player2Score {
            winnerMessage = "Player 1 wins with \(player1Score) points! Total tries: \(attempts)"
        } else if player2Score > player1Score {
            winnerMessage = "Player 2 wins with \(player2Score) points! Total tries: \(attempts)"
        } else {
            winnerMessage = "It's a tie! Both players scored \(player1Score) points. Total tries: \(attempts)"
        }
        showingEndGameAlert = true
    }
    
    //resets all stats
    func resetGame() {
        cards.shuffle()
        for i in cards.indices {
            cards[i].isFaceUp = false
            cards[i].isMatched = false
        }
        player1Score = 0
        player2Score = 0
        currentPlayer = 1
        selectedCards.removeAll()
        attempts = 0
    }
}


// makes cards/puts images on cards
struct CardView: View {
    let card: Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp || card.isMatched {
                Image(card.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(6)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
            }
        }
        .frame(width: 80, height: 80)
        .cornerRadius(10)
    }
}

struct Card: Identifiable {
    let id = UUID()
    let imageName: String
    var isFaceUp = false
    var isMatched = false
}

#Preview {
    gameView()
}
