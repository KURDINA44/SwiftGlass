//
//  AccessibilityTests.swift
//  SwiftGlass
//
//  Created by Stephen T. Sagarino Jr. on 9/26/25.
//

import SwiftUI
import Testing

@testable import SwiftGlass

@Suite("Accessibility Tests")
struct AccessibilityTests {

    @Test("Reduce transparency support")
    func testReduceTransparencySupport() async throws {
        let modifier = await GlassBackgroundModifier(
            displayMode: .automatic,
            radius: 10,
            color: .blue
        )

        await #expect(modifier.displayMode == .automatic)
    }

    @Test("Reduce motion support")
    func testReduceMotionSupport() async throws {
        let modifier = await BlobGlassModifier(
            color: .blue,
            blobIntensity: 0.5,
            animationSpeed: 1.0,
            complexity: 8,
            material: .ultraThinMaterial,
            gradientOpacity: 0.5,
            shadowOpacity: 0.3,
            respectsReduceMotion: true
        )

        await #expect(modifier.respectsReduceMotion == true)
    }
}
