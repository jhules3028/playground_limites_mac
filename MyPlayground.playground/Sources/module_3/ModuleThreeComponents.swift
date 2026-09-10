import SwiftUI

struct ModuleThreeHeader: View {
    let currentPage: Int
    let pageCount: Int
    let onExit: () -> Void

    var body: some View {
        HStack(spacing: 18) {
            Button(action: onExit) {
                Image(systemName: "house.fill")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(AppTheme.warmWhite)
                    .frame(width: 38, height: 38)
                    .background(Color.white.opacity(0.08))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white.opacity(0.12), lineWidth: 1))
            }
            .buttonStyle(.plain)
            .help("Back to cover")

            VStack(alignment: .leading, spacing: 3) {
                Text("MODULE 3")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .tracking(2)
                    .foregroundStyle(AppTheme.softGold)

                Text("Graphical Interpretation")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
            }

            Spacer()

            HStack(spacing: 8) {
                ForEach(0..<pageCount, id: \.self) { page in
                    Capsule()
                        .fill(page <= currentPage ? AppTheme.gold : Color.white.opacity(0.13))
                        .frame(width: page == currentPage ? 34 : 12, height: 7)
                        .animation(.easeInOut(duration: 0.25), value: currentPage)
                }
            }

            Text("\(currentPage + 1) / \(pageCount)")
                .font(.system(size: 12, weight: .semibold, design: .monospaced))
                .foregroundStyle(AppTheme.mutedText)
                .frame(width: 42, alignment: .trailing)
        }
        .padding(.horizontal, 48)
        .padding(.top, 32)
        .padding(.bottom, 18)
    }
}

struct ModuleThreeNavigation: View {
    let currentPage: Int
    let pageCount: Int
    let onPrevious: () -> Void
    let onNext: () -> Void

    var body: some View {
        HStack {
            Button(action: onPrevious) {
                Label(currentPage == 0 ? "Module 2" : "Previous", systemImage: "arrow.left")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .padding(.horizontal, 18)
                    .frame(height: 42)
                    .background(Color.white.opacity(0.075))
                    .clipShape(Capsule())
            }
            .buttonStyle(.plain)

            Spacer()

            Button(action: onNext) {
                HStack(spacing: 12) {
                    Text(currentPage == pageCount - 1 ? "Finish Module" : "Next")
                    Image(systemName: currentPage == pageCount - 1 ? "checkmark" : "arrow.right")
                }
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(AppTheme.deepNavy)
                .padding(.horizontal, 20)
                .frame(height: 42)
                .background(
                    LinearGradient(
                        colors: [AppTheme.softGold, AppTheme.gold],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(Capsule())
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 48)
        .padding(.top, 16)
        .padding(.bottom, 32)
    }

}

struct GraphLegend: View {
    var body: some View {
        HStack(spacing: 16) {
            LegendItem(color: AppTheme.lightBlue, title: "curve")
            LegendItem(color: AppTheme.softGold, title: "limit", isHollow: true)
            LegendItem(color: AppTheme.success, title: "moving point")
            LegendItem(color: AppTheme.error, title: "f(a)")
        }
        .font(.system(size: 10, weight: .semibold, design: .rounded))
    }
}

private struct LegendItem: View {
    let color: Color
    let title: String
    var isHollow = false

    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(isHollow ? AppTheme.navy : color)
                .frame(width: 9, height: 9)
                .overlay(Circle().stroke(color, lineWidth: isHollow ? 2 : 0))
            Text(title)
                .foregroundStyle(AppTheme.mutedText)
        }
    }
}

struct TargetCaseSelector: View {
    @Binding var selection: FunctionAtTargetCase

    var body: some View {
        VStack(spacing: 8) {
            ForEach(FunctionAtTargetCase.allCases) { targetCase in
                Button {
                    withAnimation(.easeInOut(duration: 0.24)) {
                        selection = targetCase
                    }
                } label: {
                    HStack(spacing: 11) {
                        Image(systemName: icon(for: targetCase))
                            .font(.system(size: 13, weight: .bold))
                            .frame(width: 24)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(targetCase.shortTitle)
                                .font(.system(size: 12.5, weight: .bold, design: .rounded))
                            Text(targetCase.title)
                                .font(.system(size: 10.5, weight: .medium, design: .serif))
                        }

                        Spacer()

                        if selection == targetCase {
                            Image(systemName: "checkmark")
                                .font(.system(size: 11, weight: .black))
                        }
                    }
                    .foregroundStyle(selection == targetCase ? AppTheme.deepNavy : AppTheme.warmWhite)
                    .padding(.horizontal, 13)
                    .frame(height: 48)
                    .background(selection == targetCase ? color(for: targetCase) : Color.white.opacity(0.055))
                    .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func icon(for targetCase: FunctionAtTargetCase) -> String {
        switch targetCase {
        case .continuous:
            return "equal.circle.fill"
        case .undefined:
            return "circle.dashed"
        case .different:
            return "arrow.up.and.down.circle.fill"
        }
    }

    private func color(for targetCase: FunctionAtTargetCase) -> Color {
        switch targetCase {
        case .continuous:
            return AppTheme.success
        case .undefined:
            return AppTheme.gold
        case .different:
            return AppTheme.error
        }
    }
}

struct GraphMetricCard: View {
    let label: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.system(size: 9.5, weight: .semibold, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
            Text(value)
                .font(.system(size: value.count > 9 ? 11 : 15, weight: .bold, design: .monospaced))
                .foregroundStyle(color)
                .lineLimit(1)
                .minimumScaleFactor(0.65)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 9)
        .background(Color.black.opacity(0.13))
        .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
    }
}
