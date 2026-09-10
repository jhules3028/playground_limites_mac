import Combine
import Foundation

@MainActor
final class AppState: ObservableObject {
    @Published private(set) var currentSection: AppSection = .cover
    @Published private(set) var visitedSections: Set<AppSection> = [.cover]

    func startLearning() {
        go(to: .intuitiveLimit)
    }

    func goToCover() {
        go(to: .cover)
    }

    func go(to section: AppSection) {
        currentSection = section
        visitedSections.insert(section)
    }
}
