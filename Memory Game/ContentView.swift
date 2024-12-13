//
//  ContentView.swift
//  Memory Game
//
//  Created by Jonathan V on 12/9/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    Text("Memory Master")
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundColor(.white)
                    Spacer()
                    
                    NavigationLink(destination: instructionsView()) {
                        Text("Instructions")
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: gameView()) {
                        Text("Start Game")
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Title Screen")
            .accentColor(.white)
            .toolbar(.hidden, for: .navigationBar)
        }
        .accentColor(.white)
    }
}

#Preview {
    ContentView()
}
