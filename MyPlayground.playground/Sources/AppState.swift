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

    func go(to section: AppSection) {
        currentSection = section
        visitedSections.insert(section)
    }
}
