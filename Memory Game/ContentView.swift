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
                LinearGradient(colors: [.red, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Text("Memory Master")
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundColor(.white)
                    Spacer()
                    
                    NavigationLink(destination: instructionsView()) {
                        Text("Start Game")
                            .padding()
                            .background(Color.pink)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Spacer()

                }
                .padding()
            }
            .navigationTitle("Title Screen")
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    ContentView()
}
