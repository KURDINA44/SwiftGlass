//
//  BlobShapeTests.swift
//  SwiftGlass
//
//  Created by Stephen T. Sagarino Jr. on 9/26/25.
//

import SwiftUI
import Testing

@testable import SwiftGlass

@Suite("BlobShape Tests")
struct BlobShapeTests {

    @Test("Control point generation")
    func testControlPointGeneration() async throws {
        let shape = BlobShape(complexity: 8)

        #expect(shape.controlPoints.count == 8)

        for point in shape.controlPoints {
            #expect(point.x >= 0 && point.x <= 1)
            #expect(point.y >= 0 && point.y <= 1)
        }
    }

    @Test("Path generation")
    func testPathGeneration() async throws {
        let shape = BlobShape(
            complexity: 6,
            animationProgress: 0.5,
            intensity: 0.3
        )
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)

        let path = shape.path(in: rect)

        #expect(!path.isEmpty)
    }

    @Test("Animation data")
    func testAnimationData() async throws {
        var shape = BlobShape(
            complexity: 8,
            animationProgress: 0.0,
            intensity: 0.5
        )

        #expect(shape.animatableData == 0.0)

        shape.animatableData = 1.0
        #expect(shape.animationProgress == 1.0)
    }
}
