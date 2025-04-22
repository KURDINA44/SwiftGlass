//
//  Colors.swift
//  Demo
//
//  Created by Ming on 22/4/2025.
//

import SwiftUI

// Create a ColorOption struct to keep color and name together
struct ColorOption {
    let color: Color
    let name: String
}

// Combined array of color options
let colorOptions: [ColorOption] = [
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
