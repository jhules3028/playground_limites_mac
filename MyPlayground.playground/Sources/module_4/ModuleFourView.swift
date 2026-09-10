import SwiftUI

struct ModuleFourView: View {
    @State private var currentPage = 0

    let onExit: () -> Void
    let onPreviousModule: () -> Void
    let onComplete: () -> Void

    private let pageCount = 5

    var body: some View {
        VStack(spacing: 0) {
            ModuleFourHeader(currentPage: currentPage, pageCount: pageCount, onExit: onExit)

            Group {
                switch currentPage {
                case 0:
                    ModuleFourIntroductionView()
                case 1:
                    ModuleFourSidePlayground(side: .left)
                case 2:
                    ModuleFourSidePlayground(side: .right)
                case 3:
                    ModuleFourExistenceView()
                default:
                    ModuleFourPracticeView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .id(currentPage)
            .transition(.opacity.combined(with: .move(edge: .trailing)))

            ModuleFourNavigation(
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
                .fill(AppTheme.lightBlue.opacity(0.11))
                .frame(width: 500, height: 500)
                .offset(x: -470, y: -320)

            Circle()
                .fill(AppTheme.gold.opacity(0.07))
                .frame(width: 500, height: 500)
                .offset(x: 470, y: 330)

            Text("a⁻   a⁺")
                .font(.system(size: 120, weight: .black, design: .serif))
                .foregroundStyle(Color.white.opacity(0.018))
                .offset(x: 330, y: 295)
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
