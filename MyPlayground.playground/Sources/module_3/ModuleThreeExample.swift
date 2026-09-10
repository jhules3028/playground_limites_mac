import Foundation

enum FunctionAtTargetCase: String, CaseIterable, Identifiable {
    case continuous
    case undefined
    case different

    var id: String { rawValue }

    var title: String {
        switch self {
        case .continuous:
            return "f(a) = L"
        case .undefined:
            return "f(a) no existe"
        case .different:
            return "f(a) ≠ L"
        }
    }

    var shortTitle: String {
        switch self {
        case .continuous:
            return "Coincide"
        case .undefined:
            return "Sin definir"
        case .different:
            return "Es diferente"
        }
    }

    var explanation: String {
        switch self {
        case .continuous:
            return "La función toma en a el mismo valor al que se aproxima."
        case .undefined:
            return "Hay un hueco en a, pero la curva se aproxima al mismo valor por ambos lados."
        case .different:
            return "La función tiene un punto separado en a; ese valor no cambia la tendencia cercana."
        }
    }
}

enum ModuleThreeExample {
    static let targetX = 2.0
    static let limitValue = 4.0
    static let differentFunctionValue = 6.0
    static let minimumX = -0.8
    static let maximumX = 4.8
    static let nearbyFunctionNotation = "f(x) = x + 2,  x ≠ 2"
    static let limitNotation = "limₓ→₂ (x + 2) = 4"

    static func nearbyValue(at x: Double) -> Double {
        x + 2
    }

    static func functionValue(at x: Double, targetCase: FunctionAtTargetCase) -> Double? {
        guard abs(x - targetX) < 0.005 else {
            return nearbyValue(at: x)
        }

        switch targetCase {
        case .continuous:
            return limitValue
        case .undefined:
            return nil
        case .different:
            return differentFunctionValue
        }
    }

    static func format(_ value: Double) -> String {
        String(format: "%.2f", value)
    }
}
