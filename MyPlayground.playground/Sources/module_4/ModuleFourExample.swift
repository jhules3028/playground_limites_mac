import Foundation

enum LateralSide: String, CaseIterable, Identifiable {
    case left
    case right

    var id: String { rawValue }

    var name: String {
        switch self {
        case .left:
            return "izquierda"
        case .right:
            return "derecha"
        }
    }

    var symbol: String {
        switch self {
        case .left:
            return "a⁻"
        case .right:
            return "a⁺"
        }
    }
}

enum LateralComparisonCase: String, CaseIterable, Identifiable {
    case matching
    case jump

    var id: String { rawValue }

    var title: String {
        switch self {
        case .matching:
            return "Coinciden"
        case .jump:
            return "Son diferentes"
        }
    }
}

enum ModuleFourExample {
    static let targetX = 2.0
    static let farthestDistance = 1.5
    static let closestDistance = 0.001

    static func xValue(for proximity: Double, side: LateralSide) -> Double {
        let boundedProgress = min(max(proximity, 0), 1)
        let ratio = closestDistance / farthestDistance
        let distance = farthestDistance * pow(ratio, boundedProgress)

        switch side {
        case .left:
            return targetX - distance
        case .right:
            return targetX + distance
        }
    }

    static func value(at x: Double, side: LateralSide, comparison: LateralComparisonCase = .jump) -> Double {
        switch comparison {
        case .matching:
            return side == .left ? x + 2 : -x + 6
        case .jump:
            return side == .left ? x + 1 : x + 3
        }
    }

    static func lateralLimit(for side: LateralSide, comparison: LateralComparisonCase = .jump) -> Double {
        switch comparison {
        case .matching:
            return 4
        case .jump:
            return side == .left ? 3 : 5
        }
    }

    static func format(_ value: Double) -> String {
        String(format: "%.3f", value)
    }

    static func distanceDescription(for proximity: Double) -> String {
        let x = xValue(for: proximity, side: .right)
        return format(abs(x - targetX))
    }
}
