import Foundation

enum ModuleOneExample {
    static let targetX = 2.0
    static let limitValue = 4.0
    static let minimumX = 0.2
    static let maximumX = 3.8

    static func functionValue(at x: Double) -> Double? {
        guard abs(x - targetX) > 0.004 else {
            return nil
        }

        return x + 2
    }

    static func distanceToTarget(from x: Double) -> Double {
        abs(x - targetX)
    }

    static func distanceToLimit(from x: Double) -> Double? {
        guard let value = functionValue(at: x) else {
            return nil
        }

        return abs(value - limitValue)
    }

    static func formatted(_ value: Double) -> String {
        String(format: "%.2f", value)
    }
}
