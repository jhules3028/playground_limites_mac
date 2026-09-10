import Combine
import Foundation

@MainActor
final class AppState: ObservableObject {
    @Published private(set) var currentSection: AppSection = .cover
    @Published private(set) var visitedSections: Set<AppSection> = [.cover]
    @Published private(set) var completedSections: Set<AppSection> = []

    func startLearning() {
        go(to: .intuitiveLimit)
    }

    func goToCover() {
        go(to: .cover)
    }

    func completeModuleOne() {
        completedSections.insert(.intuitiveLimit)
        go(to: .numericalLimit)
    }

    func completeModuleTwo() {
        completedSections.insert(.numericalLimit)
        go(to: .graphicalLimit)
    }

    func completeModuleThree() {
        completedSections.insert(.graphicalLimit)
        go(to: .oneSidedLimits)
    }

    func completeModuleFour() {
        completedSections.insert(.oneSidedLimits)
        go(to: .algebraicLimit)
    }

    func completeModuleFive() {
        completedSections.insert(.algebraicLimit)
        go(to: .continuity)
    }

    func completeModuleSix() {
        completedSections.insert(.continuity)
        go(to: .assessment)
    }

    func completeAssessment() {
        completedSections.insert(.assessment)
    }

    func goToModule(_ moduleNumber: Int) {
        let section: AppSection

        switch moduleNumber {
        case 1:
            section = .intuitiveLimit
        case 2:
            section = .numericalLimit
        case 3:
            section = .graphicalLimit
        case 4:
            section = .oneSidedLimits
        case 5:
            section = .algebraicLimit
        case 6:
            section = .continuity
        default:
            return
        }

        go(to: section)
    }

    func go(to section: AppSection) {
        currentSection = section
        visitedSections.insert(section)
    }
}
