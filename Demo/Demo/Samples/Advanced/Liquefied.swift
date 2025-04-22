//
//  Liquefied.swift
//  Demo
//
//  Created by Ming on 21/4/2025.
//

import SwiftUI
import SwiftGlass

struct Liquefied: View {
    var showBubbles: Bool = false
    
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
                
                if colorIndex == 0 {
                    Spacer()
                }
                
                if showBubbles {
                    thinkingBubbles
                }
                
                Spacer()
                
                if showBubbles {
                    footer
                }
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
    
    var thinkingBubbles: some View {
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
    }
    
    var footer: some View {
        HStack {
            Spacer()
            Text("SwiftGlass 1.7 - Liquefied")
                .bold()
                .font(.caption)
                .foregroundStyle(color)
                .padding(25)
                .glass(color: color, shadowColor: color)
        }
    }
}

#Preview("Bubble") {
    Liquefied()
        .preferredColorScheme(.dark)
}

#Preview("Bubbles") {
    Liquefied(showBubbles: true)
        .preferredColorScheme(.dark)
}
