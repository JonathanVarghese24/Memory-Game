//
//  gameView.swift
//  Memory Game
//
//  Created by Jonathan V on 12/9/24.
//

import SwiftUI

struct gameView: View {
    @State private var cards = [
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
    
    let columns = [
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
                    .foregroundColor(.white) // White text color
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
                            .foregroundColor(.white) // White text color
                        Text("Score: \(player1Score)")
                            .font(.subheadline)
                            .foregroundColor(.white) // White text color
                    }
                    .padding()
                    
                    VStack {
                        Text("Player 2")
                            .font(.headline)
                            .foregroundColor(.white) // White text color
                        Text("Score: \(player2Score)")
                            .font(.subheadline)
                            .foregroundColor(.white) // White text color
                    }
                    .padding()
                }
            }
        }
    }
    
    func tapCard(_ card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }),
           !cards[index].isFaceUp,
           !cards[index].isMatched,
           selectedCards.count < 2 {
            
            cards[index].isFaceUp = true
            selectedCards.append(card.id)
            
            if selectedCards.count == 2 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    checkForMatch()
                }
            }
        }
    }
    
    func checkForMatch() {
        let selectedCardIndices = cards.indices.filter { selectedCards.contains(cards[$0].id) }
        
        if cards[selectedCardIndices[0]].imageName == cards[selectedCardIndices[1]].imageName {
            cards[selectedCardIndices[0]].isMatched = true
            cards[selectedCardIndices[1]].isMatched = true
            
            // Increment score for current player
            if currentPlayer == 1 {
                player1Score += 1
            } else {
                player2Score += 1
            }
        } else {
            cards[selectedCardIndices[0]].isFaceUp = false
            cards[selectedCardIndices[1]].isFaceUp = false
            
            currentPlayer = currentPlayer == 1 ? 2 : 1
        }
        
        selectedCards.removeAll()
    }
}

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