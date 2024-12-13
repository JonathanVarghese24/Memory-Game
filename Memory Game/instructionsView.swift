//
//  instructionsView.swift
//  Memory Game
//
//  Created by Jonathan V on 12/9/24.
//

import SwiftUI

struct instructionsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    Text("Flip 2 cards and get matches!")
                        .font(.system(size: 25, weight: .heavy))
                        .foregroundColor(.white)
                    
                    Text("The app will prompt you when")
                        .font(.system(size: 25, weight: .heavy))
                        .foregroundColor(.white)
                    
                    Text("its time to switch players")
                        .font(.system(size: 25, weight: .heavy))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding()
            }
        }
        
    }
}
#Preview {
    instructionsView()
}
