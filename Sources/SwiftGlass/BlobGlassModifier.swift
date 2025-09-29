//
//  BlobShape.swift
//  SwiftGlass
//
//  Created by Ming on 21/4/2025.
//

import SwiftUI

@available(iOS 15.0, macOS 14.0, watchOS 10.0, tvOS 15.0, visionOS 1.0, *)
public struct BlobGlassModifier: ViewModifier {
    // Parameters
    let color: Color
    let blobIntensity: CGFloat
    let animationSpeed: Double
    let complexity: Int
    let material: Material
    let gradientOpacity: Double
    let shadowOpacity: Double
    let strokeWidth: CGFloat
    let shadowRadius: CGFloat
    let shadowX: CGFloat
    let shadowY: CGFloat
    let respectsReduceMotion: Bool

    // Animation state
    @State private var animationProgress: CGFloat = 0.0
    @State private var isAnimating: Bool = false

    // Cached blob shape
    private var blobShape: BlobShape {
        BlobShape(
            complexity: complexity,
            animationProgress: animationProgress,
            intensity: blobIntensity
        )
    }

    // Initializer with enhanced parameters
    public init(
        color: Color,
        blobIntensity: CGFloat,
        animationSpeed: Double,
        complexity: Int,
        material: Material,
        gradientOpacity: Double,
        shadowOpacity: Double,
        strokeWidth: CGFloat = 1.5,
        shadowRadius: CGFloat = 10,
        shadowX: CGFloat = 0,
        shadowY: CGFloat = 5,
        respectsReduceMotion: Bool = true
    ) {
        self.color = color
        self.blobIntensity = min(max(blobIntensity, 0.1), 1.0)
        self.animationSpeed = max(0.1, animationSpeed)
        self.complexity = min(max(complexity, 4), 12)
        self.material = material
        self.gradientOpacity = max(0, min(1, gradientOpacity))
        self.shadowOpacity = max(0, min(1, shadowOpacity))
        self.strokeWidth = max(0, strokeWidth)
        self.shadowRadius = max(0, shadowRadius)
        self.shadowX = shadowX
        self.shadowY = shadowY
        self.respectsReduceMotion = respectsReduceMotion
    }

    // ViewModifier Body - Optimized to use single shape instance
    public func body(content: Content) -> some View {
        let shouldAnimate = shouldAnimateBlob()

        content
            .clipShape(blobShape)
            .background(
                blobShape
                    .fill(material)
                    .overlay(
                        blobShape
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        color.opacity(gradientOpacity),
                                        color.opacity(0),
                                        color.opacity(gradientOpacity),
                                        color.opacity(0),
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: strokeWidth
                            )
                    )
                    .shadow(
                        color: color.opacity(shadowOpacity),
                        radius: shadowRadius,
                        x: shadowX,
                        y: shadowY
                    )
            )
            .onAppear {
                if shouldAnimate {
                    startAnimation()
                }
            }
            .onDisappear {
                stopAnimation()
            }
            .accessibilityLabel("Animated glass blob effect")
            .accessibilityAddTraits(
                shouldAnimate ? [] : .allowsDirectInteraction
            )
    }

    /// Determines if animation should be enabled based on accessibility settings
    private func shouldAnimateBlob() -> Bool {
        guard respectsReduceMotion else { return true }

        #if os(iOS)
            return !UIAccessibility.isReduceMotionEnabled
        #elseif os(macOS)
            return !NSWorkspace.shared.accessibilityDisplayShouldReduceMotion
        #else
            return true
        #endif
    }

    /// Starts the blob animation
    private func startAnimation() {
        guard !isAnimating else { return }
        isAnimating = true

        withAnimation(
            Animation
                .linear(duration: 10.0 / animationSpeed)
                .repeatForever(autoreverses: true)
        ) {
            animationProgress = 1.0
        }
    }

    /// Stops the blob animation
    private func stopAnimation() {
        isAnimating = false
        withAnimation(.linear(duration: 0.3)) {
            animationProgress = 0.0
        }
    }
}

// Enhanced BlobShape with improved algorithm
@available(iOS 15.0, macOS 14.0, watchOS 10.0, tvOS 15.0, visionOS 1.0, *)
public struct BlobShape: Shape {
    // Control points for the blob's perimeter
    var controlPoints: [UnitPoint]
    var animationProgress: CGFloat
    var intensity: CGFloat

    // Cached path for performance
    private static var cachedPaths: [String: Path] = [:]

    // Initializer
    public init(
        complexity: Int = 8,
        animationProgress: CGFloat = 0.0,
        intensity: CGFloat = 0.5
    ) {
        self.controlPoints = BlobShape.generateControlPoints(count: complexity)
        self.animationProgress = animationProgress
        self.intensity = intensity
    }

    // Animatable
    public var animatableData: CGFloat {
        get { animationProgress }
        set { animationProgress = newValue }
    }

    // Enhanced Path Generation with better algorithm
    public func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let minDimension = min(rect.width, rect.height)
        let radius = minDimension / 2

        // Generate cache key for performance optimization
        let cacheKey =
            "\(rect.width)_\(rect.height)_\(animationProgress)_\(intensity)_\(controlPoints.count)"

        if let cachedPath = Self.cachedPaths[cacheKey] {
            return cachedPath
        }

        // Calculate points on the blob's perimeter with improved algorithm
        let points = controlPoints.enumerated().map {
            index,
            unitPoint -> CGPoint in
            let baseAngle =
                2 * .pi * CGFloat(index) / CGFloat(controlPoints.count)
            let animatedAngle = baseAngle + (animationProgress * .pi / 4)

            // Enhanced distortion with multiple harmonics
            let distortion1 =
                sin(animatedAngle * 3 + animationProgress * 2 * .pi) * intensity
                * 0.15
            let distortion2 =
                cos(animatedAngle * 5 - animationProgress * 1.5 * .pi)
                * intensity * 0.08
            let combinedDistortion = distortion1 + distortion2

            let blobRadius = radius * (1 + combinedDistortion)
            let pointX = center.x + cos(animatedAngle) * blobRadius
            let pointY = center.y + sin(animatedAngle) * blobRadius
            return CGPoint(x: pointX, y: pointY)
        }

        // Create smooth path with cubic Bézier curves
        var path = Path()
        guard points.count > 2 else { return path }

        path.move(to: points[0])

        let count = points.count
        for i in 0..<count {
            let current = points[i]
            let next = points[(i + 1) % count]
            let nextNext = points[(i + 2) % count]
            let prev = points[(i - 1 + count) % count]

            // Improved control point calculation for smoother curves
            let controlDistance: CGFloat = 0.4
            let control1 = CGPoint(
                x: current.x + (next.x - prev.x) * controlDistance / 6,
                y: current.y + (next.y - prev.y) * controlDistance / 6
            )
            let control2 = CGPoint(
                x: next.x - (nextNext.x - current.x) * controlDistance / 6,
                y: next.y - (nextNext.y - current.y) * controlDistance / 6
            )

            path.addCurve(to: next, control1: control1, control2: control2)
        }

        path.closeSubpath()

        // Cache the path for performance
        Self.cachedPaths[cacheKey] = path

        // Limit cache size to prevent memory issues
        if Self.cachedPaths.count > 50 {
            Self.cachedPaths.removeAll()
        }

        return path
    }

    // Enhanced control point generation with proper circular distribution
    private static func generateControlPoints(count: Int) -> [UnitPoint] {
        var points = [UnitPoint]()

        for i in 0..<count {
            let angle = 2 * .pi * CGFloat(i) / CGFloat(count)
            // Add slight random variation for more organic shapes
            let randomOffset = (CGFloat.random(in: -0.1...0.1))
            let adjustedAngle = angle + randomOffset

            let x = (cos(adjustedAngle) + 1) / 2
            let y = (sin(adjustedAngle) + 1) / 2

            points.append(UnitPoint(x: x, y: y))
        }

        return points
    }

    // Clear cache method for memory management
    public static func clearCache() {
        cachedPaths.removeAll()
    }
}
