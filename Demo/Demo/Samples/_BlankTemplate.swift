//
//  _BlankTemplate.swift
//  Demo
//
//  Created by Ming on 20/4/2025.
//

import SwiftUI
import SwiftGlass

struct BlankTemplate: View {
    var body: some View {
        VStack {
            Text("Hello, Developer!")
                .padding(25)
                .glass()
        }
    }
}

#Preview("Dark") {
    BlankTemplate()
        .preferredColorScheme(.dark)
}
