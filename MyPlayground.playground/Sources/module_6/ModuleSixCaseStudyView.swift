import SwiftUI

struct ModuleSixCaseStudyView: View {
    let continuityCase: ContinuityCase
    @State private var xValue = 1.25

    private var accentColor: Color {
        switch continuityCase {
        case .continuous:
            return AppTheme.success
        case .removable:
            return AppTheme.softGold
        case .jump:
            return AppTheme.error
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 900 {
                        HStack(alignment: .top, spacing: 26) {
                            explanationPanel
                                .frame(width: 315)
                            interactivePanel
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            explanationPanel
                            interactivePanel
                        }
                    }
                }
                .frame(maxWidth: 1_040)
                .padding(.horizontal, 48)
                .padding(.vertical, 7)
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var explanationPanel: some View {
        VStack(alignment: .leading, spacing: 13) {
            LessonEyebrow(text: pageEyebrow)

            Text(continuityCase.title)
                .font(.system(size: 28, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text(continuityCase.explanation)
                .font(.system(size: 13, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)

            VStack(alignment: .leading, spacing: 6) {
                Text("FUNCTION FOR THIS CASE")
                    .font(.system(size: 9.5, weight: .bold, design: .rounded))
                    .tracking(1.2)
                    .foregroundStyle(accentColor)

                Text(continuityCase.functionNotation)
                    .font(.system(size: continuityCase == .jump ? 15 : 21, weight: .semibold, design: .serif))
                    .foregroundStyle(AppTheme.warmWhite)
                    .minimumScaleFactor(0.7)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(accentColor.opacity(0.085))
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(accentColor.opacity(0.23), lineWidth: 1)
            }

            ContinuityConditionList(continuityCase: continuityCase)

            HStack(alignment: .top, spacing: 10) {
                Image(systemName: isContinuous ? "checkmark.seal.fill" : "exclamationmark.triangle.fill")
                    .foregroundStyle(accentColor)
                Text(conclusionText)
                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(11)
            .background(accentColor.opacity(0.09))
            .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
        }
    }

    private var interactivePanel: some View {
        VStack(alignment: .leading, spacing: 11) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    LessonEyebrow(text: "Explore Around a = 2")
                    Text(graphTitle)
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                }

                Spacer()

                Text(continuityCase.shortTitle.uppercased())
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .tracking(1.2)
                    .foregroundStyle(accentColor)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(accentColor.opacity(0.1))
                    .clipShape(Capsule())
            }

            ModuleSixGraph(continuityCase: continuityCase, xValue: xValue)
                .frame(height: 280)

            HStack(spacing: 9) {
                ContinuityMetricCard(label: "x", value: ModuleSixExample.format(xValue), color: AppTheme.lightBlue)
                ContinuityMetricCard(label: "f(x)", value: displayedFunctionValue, color: accentColor)
                ContinuityMetricCard(label: "limit", value: displayedLimit, color: limitColor)
                ContinuityMetricCard(label: "f(2)", value: displayedTargetValue, color: accentColor)
            }

            Slider(value: $xValue, in: 0.2...3.8, step: 0.01)
                .tint(accentColor)

            HStack(spacing: 8) {
                ContinuityPreset(title: "Left", value: "1.90") { setX(1.9) }
                ContinuityPreset(title: "At a", value: "2.00") { setX(2) }
                ContinuityPreset(title: "Right", value: "2.10") { setX(2.1) }
            }

            Text(dynamicObservation)
                .font(.system(size: 11.5, weight: .semibold, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)
                .lineSpacing(2)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 13)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(accentColor.opacity(0.09))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }

    private var isContinuous: Bool {
        ModuleSixExample.conditionResults(for: continuityCase).allSatisfy { $0 }
    }

    private var pageEyebrow: String {
        switch continuityCase {
        case .continuous:
            return "Screen 2 · Continuous Case"
        case .removable:
            return "Screen 3 · Hole"
        case .jump:
            return "Screen 4 · Jump"
        }
    }

    private var graphTitle: String {
        switch continuityCase {
        case .continuous:
            return "The Curve and Point Match"
        case .removable:
            return "The Limit Does Not Depend on the Isolated Point"
        case .jump:
            return "The One-Sided Limits Separate"
        }
    }

    private var conclusionText: String {
        switch continuityCase {
        case .continuous:
            return "All three conditions hold. The function is continuous at x = 2."
        case .removable:
            return "Changing only f(2) from 0 to 4 would repair the function; therefore, the discontinuity is removable."
        case .jump:
            return "Although f(2) exists, changing one point cannot join two different one-sided limits."
        }
    }

    private var displayedFunctionValue: String {
        guard let value = ModuleSixExample.value(at: xValue, continuityCase: continuityCase) else {
            return "not defined"
        }
        return ModuleSixExample.format(value)
    }

    private var displayedTargetValue: String {
        guard let value = ModuleSixExample.functionAtTarget(for: continuityCase) else {
            return "does not exist"
        }
        return ModuleSixExample.format(value)
    }

    private var displayedLimit: String {
        guard let value = ModuleSixExample.bilateralLimit(for: continuityCase) else {
            return "does not exist"
        }
        return ModuleSixExample.format(value)
    }

    private var limitColor: Color {
        ModuleSixExample.bilateralLimit(for: continuityCase) == nil ? AppTheme.error : AppTheme.success
    }

    private var dynamicObservation: String {
        if abs(xValue - 2) < 0.005 {
            switch continuityCase {
            case .continuous:
                return "At x = 2, f(2) = 4 and the limit also equals 4: the graph passes through the point without interruption."
            case .removable:
                return "At x = 2, f(2) = 0 while the limit equals 4. The function is defined, but it does not equal its limit."
            case .jump:
                return "At x = 2, f(2) = 5. However, the left side approaches 3 and the right side approaches 5."
            }
        }

        let side = xValue < 2 ? "left" : "right"
        return "You are to the \(side) of a. At x = \(ModuleSixExample.format(xValue)), f(x) = \(displayedFunctionValue)."
    }

    private func setX(_ value: Double) {
        withAnimation(.easeInOut(duration: 0.28)) {
            xValue = value
        }
    }
}

private struct ContinuityPreset: View {
    let title: String
    let value: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 2) {
                Text(title)
                    .font(.system(size: 9.5, weight: .semibold, design: .rounded))
                Text(value)
                    .font(.system(size: 10.5, weight: .bold, design: .monospaced))
            }
            .foregroundStyle(AppTheme.warmWhite)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 7)
            .background(Color.white.opacity(0.06))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}
