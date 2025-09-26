//
//  PerformanceTests.swift
//  SwiftGlass
//
//  Created by Stephen T. Sagarino Jr. on 9/26/25.
//

import SwiftUI
import Testing

@testable import SwiftGlass

@Suite("Performance Tests")
struct PerformanceTests {

    @Test("Blob shape path generation performance")
    func testBlobShapePerformance() async throws {
        let shape = BlobShape(
            complexity: 12,
            animationProgress: 0.5,
            intensity: 0.8
        )
        let rect = CGRect(x: 0, y: 0, width: 200, height: 200)

        let startTime = CFAbsoluteTimeGetCurrent()

        for _ in 0..<100 {
            _ = shape.path(in: rect)
        }

        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime

        #expect(timeElapsed < 1.0)
    }

    @Test("Cache functionality")
    func testCacheFunctionality() async throws {
        let shape = BlobShape(complexity: 8)
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)

        BlobShape.clearCache()

        let startTime1 = CFAbsoluteTimeGetCurrent()
        _ = shape.path(in: rect)
        let time1 = CFAbsoluteTimeGetCurrent() - startTime1

        let startTime2 = CFAbsoluteTimeGetCurrent()
        _ = shape.path(in: rect)
        let time2 = CFAbsoluteTimeGetCurrent() - startTime2

        #expect(time2 <= time1)
    }
}
