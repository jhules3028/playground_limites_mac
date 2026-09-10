import Foundation

enum ContinuityCase: String, CaseIterable, Identifiable {
    case continuous
    case removable
    case jump

    var id: String { rawValue }

    var title: String {
        switch self {
        case .continuous:
            return "Continuous Function"
        case .removable:
            return "Removable Discontinuity"
        case .jump:
            return "Jump Discontinuity"
        }
    }

    var shortTitle: String {
        switch self {
        case .continuous:
            return "Continuous"
        case .removable:
            return "Hole"
        case .jump:
            return "Jump"
        }
    }

    var explanation: String {
        switch self {
        case .continuous:
            return "The curve reaches the same point from both sides, and the function takes exactly that value."
        case .removable:
            return "The curve approaches 4, but the exact point is defined at 0. The limit exists even though the function is not continuous."
        case .jump:
            return "Each side approaches a different height. Therefore, the two-sided limit does not exist."
        }
    }

    var functionNotation: String {
        switch self {
        case .continuous:
            return "f(x) = x + 2"
        case .removable:
            return "f(x) = ⎧ x + 2,  if x ≠ 2\n       ⎩ 0,      if x = 2"
        case .jump:
            return "f(x) = x + 1 if x < 2;  x + 3 if x ≥ 2"
        }
    }
}

enum ModuleSixExample {
    static let targetX = 2.0

    static func value(at x: Double, continuityCase: ContinuityCase) -> Double? {
        if abs(x - targetX) < 0.005 {
            return functionAtTarget(for: continuityCase)
        }

        switch continuityCase {
        case .continuous, .removable:
            return x + 2
        case .jump:
            return x < targetX ? x + 1 : x + 3
        }
    }

    static func functionAtTarget(for continuityCase: ContinuityCase) -> Double? {
        switch continuityCase {
        case .continuous:
            return 4
        case .removable:
            return 0
        case .jump:
            return 5
        }
    }

    static func leftLimit(for continuityCase: ContinuityCase) -> Double {
        continuityCase == .jump ? 3 : 4
    }

    static func rightLimit(for continuityCase: ContinuityCase) -> Double {
        continuityCase == .jump ? 5 : 4
    }

    static func bilateralLimit(for continuityCase: ContinuityCase) -> Double? {
        let left = leftLimit(for: continuityCase)
        let right = rightLimit(for: continuityCase)
        return abs(left - right) < 0.000_001 ? left : nil
    }

    static func conditionResults(for continuityCase: ContinuityCase) -> [Bool] {
        let functionValue = functionAtTarget(for: continuityCase)
        let limit = bilateralLimit(for: continuityCase)
        let valuesMatch: Bool

        if let functionValue, let limit {
            valuesMatch = abs(functionValue - limit) < 0.000_001
        } else {
            valuesMatch = false
        }

        return [functionValue != nil, limit != nil, valuesMatch]
    }

    static func format(_ value: Double) -> String {
        String(format: "%.2f", value)
    }
}
