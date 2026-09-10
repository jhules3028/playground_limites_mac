import Foundation

enum AppSection: Int, CaseIterable, Identifiable {
    case cover
    case intuitiveLimit
    case numericalLimit
    case graphicalLimit
    case oneSidedLimits
    case algebraicLimit
    case continuity
    case assessment

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .cover:
            return "Portada"
        case .intuitiveLimit:
            return "Idea intuitiva"
        case .numericalLimit:
            return "Representación numérica"
        case .graphicalLimit:
            return "Interpretación gráfica"
        case .oneSidedLimits:
            return "Límites laterales"
        case .algebraicLimit:
            return "Cálculo algebraico"
        case .continuity:
            return "Continuidad"
        case .assessment:
            return "Evaluación final"
        }
    }

    var moduleNumber: Int? {
        guard self != .cover else { return nil }
        return rawValue
    }
}
