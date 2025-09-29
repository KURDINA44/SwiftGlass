//
//  BlobGlassModifierTests.swift
//  SwiftGlass
//
//  Created by Stephen T. Sagarino Jr. on 9/26/25.
//

import SwiftUI
import Testing

@testable import SwiftGlass

@Suite("BlobGlassModifier Tests")
struct BlobGlassModifierTests {

    @Test("Blob intensity validation")
    func testBlobIntensityValidation() async throws {
        let lowIntensity = await BlobGlassModifier(
            color: .blue,
            blobIntensity: -0.5,
            animationSpeed: 1.0,
            complexity: 8,
            material: .ultraThinMaterial,
            gradientOpacity: 0.5,
            shadowOpacity: 0.3
        )

        let highIntensity = await BlobGlassModifier(
            color: .blue,
            blobIntensity: 2.0,
            animationSpeed: 1.0,
            complexity: 8,
            material: .ultraThinMaterial,
            gradientOpacity: 0.5,
            shadowOpacity: 0.3
        )

        await #expect(lowIntensity.blobIntensity >= 0.1)
        await #expect(highIntensity.blobIntensity <= 1.0)
    }

    @Test("Complexity validation")
    func testComplexityValidation() async throws {
        let lowComplexity = await BlobGlassModifier(
            color: .blue,
            blobIntensity: 0.5,
            animationSpeed: 1.0,
            complexity: 2,
            material: .ultraThinMaterial,
            gradientOpacity: 0.5,
            shadowOpacity: 0.3
        )

        let highComplexity = await BlobGlassModifier(
            color: .blue,
            blobIntensity: 0.5,
            animationSpeed: 1.0,
            complexity: 20,
            material: .ultraThinMaterial,
            gradientOpacity: 0.5,
            shadowOpacity: 0.3
        )

        await #expect(lowComplexity.complexity >= 4)
        await #expect(highComplexity.complexity <= 12)
    }
}
