import SwiftUI

struct ModuleThreeView: View {
    @State private var currentPage = 0

    let onExit: () -> Void
    let onPreviousModule: () -> Void
    let onComplete: () -> Void

    private let pageCount = 3

    var body: some View {
        VStack(spacing: 0) {
            ModuleThreeHeader(
                currentPage: currentPage,
                pageCount: pageCount,
                onExit: onExit
            )

            Group {
                switch currentPage {
                case 0:
                    ModuleThreeReadingView()
                case 1:
                    ModuleThreeExploreView()
                default:
                    ModuleThreeSummaryView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .id(currentPage)
            .transition(.opacity.combined(with: .move(edge: .trailing)))

            ModuleThreeNavigation(
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
                .fill(AppTheme.lightBlue.opacity(0.13))
                .frame(width: 540, height: 540)
                .offset(x: 450, y: -315)

            Circle()
                .fill(AppTheme.gold.opacity(0.05))
                .frame(width: 380, height: 380)
                .offset(x: -470, y: 340)

            Text("f(x)")
                .font(.system(size: 160, weight: .black, design: .serif))
                .foregroundStyle(Color.white.opacity(0.018))
                .rotationEffect(.degrees(-8))
                .offset(x: 390, y: 300)
        }
        .ignoresSafeArea()
    }

    private func showPreviousPage() {
        guard currentPage > 0 else {
            onPreviousModule()
            return
        }

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
