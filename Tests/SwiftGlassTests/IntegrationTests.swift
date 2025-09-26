//
//  IntegrationTests.swift
//  SwiftGlass
//
//  Created by Stephen T. Sagarino Jr. on 9/26/25.
//

import SwiftUI
import Testing

@testable import SwiftGlass

@Suite("Integration Tests")
struct IntegrationTests {

    @Test("Glass modifier integration")
    func testGlassModifierIntegration() async throws {
        _ = await Text("Test")
            .glass(
                displayMode: .always,
                radius: 16,
                color: .blue,
                material: .regularMaterial
            )
    }

    @Test("Liquefied glass integration")
    func testLiquefiedGlassIntegration() async throws {
        _ = await Text("Test")
            .liquefiedGlass(
                color: .purple,
                blobIntensity: 0.7,
                animationSpeed: 1.5,
                complexity: 10
            )

    }

}
