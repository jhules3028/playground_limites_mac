import SwiftUI

struct ModuleFourIntroductionView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 880 {
                        HStack(alignment: .top, spacing: 28) {
                            explanationPanel
                                .frame(width: 350)
                            visualPanel
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            explanationPanel
                            visualPanel
                        }
                    }
                }
                .frame(maxWidth: 1_040)
                .padding(.horizontal, 48)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var explanationPanel: some View {
        VStack(alignment: .leading, spacing: 15) {
            LessonEyebrow(text: "Screen 1 · Understand")

            Text("One Point, Two Directions")
                .font(.system(size: 31, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text("A one-sided limit examines what happens from only one side of the target point. The small sign indicates the direction of approach.")
                .font(.system(size: 13.5, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            LateralDefinitionCard(
                side: .left,
                expression: "limₓ→ₐ⁻ f(x)",
                description: "Use values less than a and move toward the right."
            )

            LateralDefinitionCard(
                side: .right,
                expression: "limₓ→ₐ⁺ f(x)",
                description: "Use values greater than a and move toward the left."
            )
        }
    }

    private var visualPanel: some View {
        VStack(alignment: .leading, spacing: 13) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    LessonEyebrow(text: "Jump Example")
                    Text("Each Side Tells Its Own Story")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                }

                Spacer()

                HStack(spacing: 12) {
                    DirectionLegend(color: AppTheme.lightBlue, text: "left")
                    DirectionLegend(color: AppTheme.softGold, text: "right")
                }
            }

            ModuleFourGraph(comparison: .jump)
                .frame(height: 300)

            ModuleCard {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Example Function")
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .tracking(1.2)
                        .foregroundStyle(AppTheme.softGold)

                    HStack(spacing: 15) {
                        Text("f(x) =")
                            .font(.system(size: 18, weight: .semibold, design: .serif))
                            .foregroundStyle(AppTheme.warmWhite)

                        VStack(alignment: .leading, spacing: 5) {
                            Text("x + 1,   if x < 2")
                                .foregroundStyle(AppTheme.lightBlue)
                            Text("x + 3,   if x > 2")
                                .foregroundStyle(AppTheme.softGold)
                        }
                        .font(.system(size: 14, weight: .bold, design: .monospaced))

                        Spacer()
                    }

                    Text("First, we will analyze each direction separately; then we will decide whether the two-sided limit exists.")
                        .font(.system(size: 11.5, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.mutedText)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}

private struct DirectionLegend: View {
    let color: Color
    let text: String

    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(color)
                .frame(width: 9, height: 9)
            Text(text)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
        }
    }
}
