//
//  ContentView.swift
//  MatrixRainEffect
//
//  Created by Angelos Staboulis on 6/9/25.
//

import SwiftUI

struct ContentView: View {
    let columns: Int = 20 // Number of columns for the Matrix effect
    let rows: Int = 30 // Number of rows for the Matrix effect
    let symbols: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")"]
    
    @State private var drops: [[Int]] // Keeps track of each drop’s position
    
    init() {
        // Initialize drop positions randomly
        self._drops = State(initialValue: Array(repeating: Array(repeating: 0, count: 30), count: 20)) // 20 columns, 30 rows
    }
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // For each column, we animate falling symbols
                ForEach(0..<columns, id: \.self) { column in
                    VStack(spacing: 0) {
                        ForEach(0..<rows, id: \.self) { row in
                            Text(self.symbols.randomElement()!)
                                .foregroundColor(Color.green.opacity(0.7))
                                .font(.system(size: 20, weight: .bold))
                                .position(x: CGFloat(column * 20), y: CGFloat(drops[column][row]))
                                .onAppear {
                                    if drops[column][row] == 0 {
                                        drops[column][row] = Int.random(in: 0..<30)
                                    }
                                }
                                .animation(
                                    Animation.linear(duration: Double.random(in: 0.5...2))
                                        .repeatForever(autoreverses: false)
                                        .delay(Double(row) * 0.05), value: drops[column][row]
                                )
                        }
                    }
                }
            }
            .onAppear {
                // Start the matrix animation
                for i in 0..<columns {
                    for j in 0..<rows {
                        drops[i][j] = Int.random(in: 0..<30)
                    }
                }
            }
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
