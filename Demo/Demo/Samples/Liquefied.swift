//
//  Liquefied.swift
//  Demo
//
//  Created by Ming on 21/4/2025.
//

import SwiftUI
import SwiftGlass

struct Liquefied: View {
    @State private var colorIndex: Int = 0
    @State private var timer: Timer? = nil
    
    // Use computed properties to get current color and name
    private var color: Color {
        // Get the current color from colorOptions
        return colorOptions[colorIndex].color
    }
    
    private var colorName: String {
        // Get the current color name from colorOptions
        return colorOptions[colorIndex].name
    }

    var body: some View {
        ZStack {
            // Background color with opacity
            color
                .opacity(0.2)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                // Animated color name text
                Text(colorIndex == 0 ? "" : colorName)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundStyle(color)
                    .padding(colorIndex == 0 ? 0 : 100)
                    .liquefiedGlass(color: color, blobIntensity: 0.2)
                    .contentTransition(.numericText(countsDown: true))
                
                // Uncomment below for animated circles
                /*
                if colorIndex == 0 {
                    Spacer()
                }
                
                ForEach(Array(zip([100, 50, 30, 10], [
                    CGPoint(x: 40, y: 15),
                    CGPoint(x: 70, y: 30),
                    CGPoint(x: 90, y: 50),
                    CGPoint(x: 110, y: 65),
                ])), id: \.0) { size, offset in
                    Circle()
                        .fill(.clear)
                        .liquefiedGlass(color: color, blobIntensity: 0.2)
                        .frame(width: colorIndex == 0 ? 0 : CGFloat(size), height: colorIndex == 0 ? 0 : CGFloat(size))
                        .offset(x: offset.x, y: offset.y)
                }
                */
                
                Spacer()
                
                // Uncomment below for footer label
                /*
                HStack {
                    Spacer()
                    Text("SwiftGlass 1.7 - Liquefied")
                        .bold()
                        .font(.caption)
                        .foregroundStyle(color)
                        .padding(25)
                        .glass(color: color, shadowColor: color)
                }
                */
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal)
        }
        .onAppear {
            // Start timer to cycle colors
            timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 1.5)) {
                    colorIndex = (colorIndex + 1) % colorOptions.count
                }
            }
        }
        .onDisappear {
            // Invalidate timer when view disappears
            timer?.invalidate()
            timer = nil
        }
    }
}

#Preview("Dark") {
    Liquefied()
        .preferredColorScheme(.dark)
}

// Create a ColorOption struct to keep color and name together
private struct ColorOption {
    let color: Color
    let name: String
}

// Combined array of color options
private let colorOptions: [ColorOption] = [
    // SwiftUI Colors
    ColorOption(color: .gray, name: "gray"),
    ColorOption(color: .blue, name: "blue"),
    ColorOption(color: .purple, name: "purple"),
    ColorOption(color: .green, name: "green"),
    ColorOption(color: .orange, name: "orange"),
    ColorOption(color: .pink, name: "pink"),
    ColorOption(color: .red, name: "red"),
    ColorOption(color: .yellow, name: "yellow"),
    ColorOption(color: .cyan, name: "cyan"),
    ColorOption(color: .indigo, name: "indigo"),
    ColorOption(color: .mint, name: "mint"),
    ColorOption(color: .teal, name: "teal"),
    ColorOption(color: .brown, name: "brown"),

    // Luxury Collection
    // ColorOption(color: Color(red: 0.98, green: 0.48, blue: 0.21), name: "Hermes Orange"),
    // ColorOption(color: Color(red: 0.51, green: 0.85, blue: 0.82), name: "Tiffany Blue"),
    // ColorOption(color: Color(red: 0.10, green: 0.50, blue: 0.26), name: "Gucci Green"),
    // ColorOption(color: Color(red: 0.85, green: 0.79, blue: 0.72), name: "Burberry Beige"),
    // ColorOption(color: Color(red: 0.76, green: 0.70, blue: 0.38), name: "Versace Gold"),
    // ColorOption(color: Color(red: 0.98, green: 0.83, blue: 0.26), name: "Fendi Yellow"),
    // ColorOption(color: Color(red: 0.71, green: 0.12, blue: 0.16), name: "Cartier Red"),
    // ColorOption(color: Color(red: 0.30, green: 0.18, blue: 0.15), name: "Louis Vuitton Brown"),
]
