import SwiftUI

struct ModuleSixView: View {
    @State private var currentPage = 0

    let onExit: () -> Void
    let onPreviousModule: () -> Void
    let onComplete: () -> Void

    private let pageCount = 5

    var body: some View {
        VStack(spacing: 0) {
            ModuleSixHeader(currentPage: currentPage, pageCount: pageCount, onExit: onExit)

            Group {
                switch currentPage {
                case 0:
                    ModuleSixIntroductionView()
                case 1:
                    ModuleSixCaseStudyView(continuityCase: .continuous)
                case 2:
                    ModuleSixCaseStudyView(continuityCase: .removable)
                case 3:
                    ModuleSixCaseStudyView(continuityCase: .jump)
                default:
                    ModuleSixAssessmentView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .id(currentPage)
            .transition(.opacity.combined(with: .move(edge: .trailing)))

            ModuleSixNavigation(
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
                .fill(AppTheme.success.opacity(0.075))
                .frame(width: 520, height: 520)
                .offset(x: 480, y: -330)

            Circle()
                .fill(AppTheme.lightBlue.opacity(0.09))
                .frame(width: 470, height: 470)
                .offset(x: -480, y: 340)

            Text("lim = f(a)")
                .font(.system(size: 110, weight: .black, design: .serif))
                .foregroundStyle(Color.white.opacity(0.016))
                .rotationEffect(.degrees(-6))
                .offset(x: 335, y: 305)
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
