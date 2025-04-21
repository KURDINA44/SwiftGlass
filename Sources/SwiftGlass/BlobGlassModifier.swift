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
    
    // Animation state
    @State private var animationProgress: CGFloat = 0.0
    
    // Initializer
    public init(
        color: Color,
        blobIntensity: CGFloat,
        animationSpeed: Double,
        complexity: Int,
        material: Material,
        gradientOpacity: Double,
        shadowOpacity: Double
    ) {
        self.color = color
        self.blobIntensity = min(max(blobIntensity, 0.1), 1.0) // Constrain between 0.1 and 1.0
        self.animationSpeed = animationSpeed
        self.complexity = min(max(complexity, 4), 12) // Constrain between 4 and 12
        self.material = material
        self.gradientOpacity = gradientOpacity
        self.shadowOpacity = shadowOpacity
    }
    
    // ViewModifier Body
    public func body(content: Content) -> some View {
        content
            // Clip content to animated blob shape
            .clipShape(
                BlobShape(
                    complexity: complexity,
                    animationProgress: animationProgress,
                    intensity: blobIntensity
                )
            )
            // Blob glass background and effects
            .background(
                BlobShape(
                    complexity: complexity,
                    animationProgress: animationProgress,
                    intensity: blobIntensity
                )
                .fill(material)
                .overlay(
                    BlobShape(
                        complexity: complexity,
                        animationProgress: animationProgress,
                        intensity: blobIntensity
                    )
                    .stroke(
                        LinearGradient(
                            colors: [
                                color.opacity(gradientOpacity),
                                color.opacity(0),
                                color.opacity(gradientOpacity),
                                color.opacity(0)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1.5
                    )
                )
                .shadow(
                    color: color.opacity(shadowOpacity),
                    radius: 10,
                    x: 0,
                    y: 5
                )
            )
            .onAppear {
                // Start the continuous animation
                withAnimation(
                    Animation
                        .linear(duration: 10 / animationSpeed)
                        .repeatForever(autoreverses: true)
                ) {
                    animationProgress = 1.0
                }
            }
    }
}

// BlobShape
@available(iOS 15.0, macOS 14.0, watchOS 10.0, tvOS 15.0, visionOS 1.0, *)
public struct BlobShape: Shape {
    // Control points for the blob's perimeter
    var controlPoints: [UnitPoint]
    var animationProgress: CGFloat
    var intensity: CGFloat
    
    // Initializer
    public init(complexity: Int = 8, animationProgress: CGFloat = 0.0, intensity: CGFloat = 0.5) {
        self.controlPoints = BlobShape.generateControlPoints(count: complexity)
        self.animationProgress = animationProgress
        self.intensity = intensity
    }
    
    // Animatable
    public var animatableData: CGFloat {
        get { animationProgress }
        set { animationProgress = newValue }
    }
    
    // Path Generation
    public func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let minDimension = min(rect.width, rect.height)
        let radius = minDimension / 2
        
        // Calculate points on the blob's perimeter
        let points = controlPoints.map { unitPoint -> CGPoint in
            let angle = 2 * .pi * unitPoint.x + (animationProgress * 2 * .pi)
            let distortionAmount = sin(angle * 3 + animationProgress * 4) * intensity * 0.2
            let blobRadius = radius * (1 + distortionAmount)
            let pointX = center.x + cos(angle) * blobRadius
            let pointY = center.y + sin(angle) * blobRadius
            return CGPoint(x: pointX, y: pointY)
        }
        
        // Use cubic Bézier curves for smoothness
        var path = Path()
        guard points.count > 2 else { return path }
        
        path.move(to: points[0])
        
        // Calculate control points for smooth cubic Bézier curves
        let count = points.count
        for i in 0..<count {
            let prev = points[(i - 1 + count) % count]
            let curr = points[i]
            let next = points[(i + 1) % count]
            let next2 = points[(i + 2) % count]
            
            // Calculate control points for smoothness
            let control1 = CGPoint(
                x: curr.x + (next.x - prev.x) / 6,
                y: curr.y + (next.y - prev.y) / 6
            )
            let control2 = CGPoint(
                x: next.x - (next2.x - curr.x) / 6,
                y: next.y - (next2.y - curr.y) / 6
            )
            
            path.addCurve(to: next, control1: control1, control2: control2)
        }
        
        path.closeSubpath()
        return path
    }
    
    // Helper: Generate evenly distributed control points around a circle
    private static func generateControlPoints(count: Int) -> [UnitPoint] {
        var points = [UnitPoint]()
        let angleStep = 1.0 / CGFloat(count)
        
        for i in 0..<count {
            let angle = CGFloat(i) * angleStep
            points.append(UnitPoint(x: angle, y: angle))
        }
        
        return points
    }
}
