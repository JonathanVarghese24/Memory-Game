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
                LinearGradient(colors: [.red, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack {
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
