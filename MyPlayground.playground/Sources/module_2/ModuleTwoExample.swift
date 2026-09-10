import Foundation

struct NumericalLimitRow: Identifiable {
    let precision: Int
    let leftX: Double
    let leftResult: Double
    let rightX: Double
    let rightResult: Double

    var id: Int { precision }
}

enum ModuleTwoExample {
    static let targetX = 2.0
    static let limitValue = 4.0
    static let supportedPrecisions = [1, 2, 3]

    static func originalFunction(at x: Double) -> Double? {
        guard abs(x - targetX) > 0.000_000_1 else {
            return nil
        }

        return ((x * x) - 4) / (x - 2)
    }

    static func row(for precision: Int) -> NumericalLimitRow {
        let distance = pow(10.0, -Double(precision))
        let leftX = targetX - distance
        let rightX = targetX + distance

        return NumericalLimitRow(
            precision: precision,
            leftX: leftX,
            leftResult: originalFunction(at: leftX) ?? .nan,
            rightX: rightX,
            rightResult: originalFunction(at: rightX) ?? .nan
        )
    }

    static var rows: [NumericalLimitRow] {
        supportedPrecisions.map(row(for:))
    }

    static func format(_ value: Double, precision: Int) -> String {
        String(format: "%.*f", precision, value)
    }

    static func distanceDescription(for precision: Int) -> String {
        let distance = pow(10.0, -Double(precision))
        return format(distance, precision: precision)
    }
}
