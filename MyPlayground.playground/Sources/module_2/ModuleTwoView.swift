import SwiftUI

struct ModuleTwoView: View {
    @State private var currentPage = 0

    let onExit: () -> Void
    let onPreviousModule: () -> Void
    let onComplete: () -> Void

    private let pageCount = 3

    var body: some View {
        VStack(spacing: 0) {
            ModuleTwoHeader(
                currentPage: currentPage,
                pageCount: pageCount,
                onExit: onExit
            )

            Group {
                switch currentPage {
                case 0:
                    ModuleTwoTableView()
                case 1:
                    ModuleTwoPrecisionView()
                default:
                    ModuleTwoSummaryView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .id(currentPage)
            .transition(.opacity.combined(with: .move(edge: .trailing)))

            ModuleTwoNavigation(
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
                .fill(AppTheme.lightBlue.opacity(0.12))
                .frame(width: 500, height: 500)
                .offset(x: 450, y: -310)

            Circle()
                .fill(AppTheme.gold.opacity(0.05))
                .frame(width: 390, height: 390)
                .offset(x: -460, y: 340)

            Text(".999")
                .font(.system(size: 170, weight: .black, design: .monospaced))
                .foregroundStyle(Color.white.opacity(0.018))
                .rotationEffect(.degrees(-8))
                .offset(x: 390, y: 290)
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
