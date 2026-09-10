import SwiftUI

struct ModuleOneView: View {
    @State private var currentPage = 0

    let onExit: () -> Void
    let onComplete: () -> Void

    private let pageCount = 3

    var body: some View {
        VStack(spacing: 0) {
            ModuleOneHeader(
                currentPage: currentPage,
                pageCount: pageCount,
                onExit: onExit
            )

            Group {
                switch currentPage {
                case 0:
                    ModuleOneConceptView()
                case 1:
                    ModuleOneExploreView()
                default:
                    ModuleOneSummaryView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .id(currentPage)
            .transition(.opacity.combined(with: .move(edge: .trailing)))

            ModuleOneNavigation(
                currentPage: currentPage,
                pageCount: pageCount,
                onPrevious: showPreviousPage,
                onNext: showNextPage
            )
        }
        .background(moduleBackground)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(AppTheme.gold.opacity(0.42), lineWidth: 1.2)
                .padding(18)
                .allowsHitTesting(false)
        }
    }

    private var moduleBackground: some View {
        ZStack {
            AppTheme.background

            Circle()
                .fill(AppTheme.blue.opacity(0.22))
                .frame(width: 520, height: 520)
                .offset(x: 440, y: -300)

            Circle()
                .fill(AppTheme.gold.opacity(0.055))
                .frame(width: 360, height: 360)
                .offset(x: -470, y: 330)
        }
        .ignoresSafeArea()
    }

    private func showPreviousPage() {
        guard currentPage > 0 else { return }

        withAnimation(.easeInOut(duration: 0.32)) {
            currentPage -= 1
        }
    }

    private func showNextPage() {
        guard currentPage < pageCount - 1 else {
            onComplete()
            return
        }

        withAnimation(.easeInOut(duration: 0.32)) {
            currentPage += 1
        }
    }
}
