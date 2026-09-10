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
            return "Cover"
        case .intuitiveLimit:
            return "Intuitive idea"
        case .numericalLimit:
            return "Numerical representation"
        case .graphicalLimit:
            return "Graphical interpretation"
        case .oneSidedLimits:
            return "One-sided limits"
        case .algebraicLimit:
            return "Algebraic techniques"
        case .continuity:
            return "Continuity"
        case .assessment:
            return "Final assessment"
        }
    }

    var moduleNumber: Int? {
        guard self != .cover else { return nil }
        return rawValue
    }
}
