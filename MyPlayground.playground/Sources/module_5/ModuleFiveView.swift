import SwiftUI

struct ModuleFiveView: View {
    @State private var currentPage = 0

    let onExit: () -> Void
    let onPreviousModule: () -> Void
    let onComplete: () -> Void

    private let pageCount = 5

    var body: some View {
        VStack(spacing: 0) {
            ModuleFiveHeader(currentPage: currentPage, pageCount: pageCount, onExit: onExit)

            Group {
                switch currentPage {
                case 0:
                    ModuleFiveDirectView()
                case 1:
                    ModuleFiveIndeterminateView()
                case 2:
                    ModuleFiveFactoringView()
                case 3:
                    ModuleFiveRationalizationView()
                default:
                    ModuleFiveAssessmentView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .id(currentPage)
            .transition(.opacity.combined(with: .move(edge: .trailing)))

            ModuleFiveNavigation(
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
                .fill(AppTheme.gold.opacity(0.065))
                .frame(width: 520, height: 520)
                .offset(x: 470, y: -330)

            Circle()
                .fill(AppTheme.lightBlue.opacity(0.09))
                .frame(width: 470, height: 470)
                .offset(x: -480, y: 340)

            Text("0/0")
                .font(.system(size: 150, weight: .black, design: .serif))
                .foregroundStyle(Color.white.opacity(0.017))
                .rotationEffect(.degrees(-7))
                .offset(x: 360, y: 300)
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
