import Foundation

enum AlgebraicMethod: String, CaseIterable, Identifiable {
    case directSubstitution
    case factoring
    case rationalization

    var id: String { rawValue }

    var title: String {
        switch self {
        case .directSubstitution:
            return "Sustitución directa"
        case .factoring:
            return "Factorización"
        case .rationalization:
            return "Racionalización"
        }
    }

    var summary: String {
        switch self {
        case .directSubstitution:
            return "Sustituye a cuando la expresión está definida y no aparece una forma problemática."
        case .factoring:
            return "Úsala cuando un polinomio puede revelar un factor común que provoca la forma 0/0."
        case .rationalization:
            return "Usa el conjugado cuando intervienen raíces y la sustitución produce 0/0."
        }
    }
}

enum ModuleFiveExample {
    static let directTarget = 2.0
    static let factoringTarget = 2.0
    static let rationalizationTarget = 4.0

    static func directFunction(at x: Double) -> Double {
        3 * x + 1
    }

    static func factoringOriginal(at x: Double) -> Double? {
        let denominator = x - 2
        guard abs(denominator) > 0.000_001 else { return nil }
        return (x * x - 4) / denominator
    }

    static func factoringSimplified(at x: Double) -> Double {
        x + 2
    }

    static func rationalizationOriginal(at x: Double) -> Double? {
        guard x >= 0 else { return nil }
        let denominator = x - 4
        guard abs(denominator) > 0.000_001 else { return nil }
        return (sqrt(x) - 2) / denominator
    }

    static func rationalizationSimplified(at x: Double) -> Double? {
        guard x >= 0 else { return nil }
        let denominator = sqrt(x) + 2
        guard abs(denominator) > 0.000_001 else { return nil }
        return 1 / denominator
    }

    static func firstAssessmentFunction(at x: Double) -> Double {
        2 * x * x - x + 1
    }

    static func secondAssessmentSimplified(at x: Double) -> Double {
        x + 3
    }

    static func format(_ value: Double) -> String {
        if abs(value.rounded() - value) < 0.000_001 {
            return String(Int(value.rounded()))
        }
        return String(format: "%.3f", value)
    }
}
