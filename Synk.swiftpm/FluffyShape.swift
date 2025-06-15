//  Created by @dardarius aka Dario Saldamarco

import SwiftUI

struct FluffyShape: Shape {
    let name: String

    func path(in rect: CGRect) -> Path {
        var path = Path()
        _ = rect.width
        _ = rect.height

        let randomOffset = abs(name.hashValue % 10)
        let controlOffset = CGFloat(randomOffset) * 2.5

        path.move(to: CGPoint(x: rect.midX, y: rect.minY + controlOffset))
        
        path.addCurve(
            to: CGPoint(x: rect.maxX - controlOffset, y: rect.midY - controlOffset),
            control1: CGPoint(x: rect.maxX + controlOffset, y: rect.minY),
            control2: CGPoint(x: rect.maxX, y: rect.midY - controlOffset * 2)
        )

        path.addCurve(
            to: CGPoint(x: rect.midX + controlOffset, y: rect.maxY - controlOffset),
            control1: CGPoint(x: rect.maxX - controlOffset * 2, y: rect.maxY),
            control2: CGPoint(x: rect.midX + controlOffset, y: rect.maxY + controlOffset)
        )

        path.addCurve(
            to: CGPoint(x: rect.minX + controlOffset, y: rect.midY + controlOffset),
            control1: CGPoint(x: rect.minX, y: rect.maxY - controlOffset * 2),
            control2: CGPoint(x: rect.minX - controlOffset, y: rect.midY + controlOffset * 2)
        )

        path.addCurve(
            to: CGPoint(x: rect.midX, y: rect.minY + controlOffset),
            control1: CGPoint(x: rect.minX + controlOffset * 2, y: rect.minY - controlOffset),
            control2: CGPoint(x: rect.midX - controlOffset, y: rect.minY - controlOffset)
        )

        return path
    }
}
