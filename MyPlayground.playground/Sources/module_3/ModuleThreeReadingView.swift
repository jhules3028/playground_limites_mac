import SwiftUI

struct ModuleThreeReadingView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 880 {
                        HStack(alignment: .top, spacing: 28) {
                            explanationPanel
                                .frame(width: 325)
                            graphPanel
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            explanationPanel
                            graphPanel
                        }
                    }
                }
                .frame(maxWidth: 1_040)
                .padding(.horizontal, 48)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var explanationPanel: some View {
        VStack(alignment: .leading, spacing: 16) {
            LessonEyebrow(text: "Screen 1 · Read")

            Text("A Limit Seen on a Graph")
                .font(.system(size: 31, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text("A graph lets us observe the trend of f(x) as x approaches the target point a.")
                .font(.system(size: 14, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            Text(ModuleThreeExample.nearbyFunctionNotation)
                .font(.system(size: 18, weight: .semibold, design: .serif))
                .foregroundStyle(AppTheme.softGold)
                .padding(.horizontal, 14)
                .padding(.vertical, 9)
                .frame(maxWidth: .infinity)
                .background(AppTheme.gold.opacity(0.09))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            ModuleCard {
                VStack(alignment: .leading, spacing: 11) {
                    GraphElementRow(icon: "arrow.left.and.right", text: "The axes locate the values of x and y.")
                    GraphElementRow(icon: "waveform.path.ecg", text: "The curve shows the behavior of the function.")
                    GraphElementRow(icon: "scope", text: "The gold guides mark a = 2 and L = 4.")
                    GraphElementRow(icon: "circle", text: "The hole indicates that f(2) is undefined.")
                }
            }

            HStack(spacing: 10) {
                ExpressionBadge(expression: ModuleThreeExample.limitNotation, caption: "nearby behavior")
                ExpressionBadge(expression: "f(2)", caption: "exact value")
            }
        }
    }

    private var graphPanel: some View {
        VStack(alignment: .leading, spacing: 13) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    LessonEyebrow(text: "Visual example")
                    Text("Approaching Does Not Mean Reaching")
                        .font(.system(size: 23, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                }

                Spacer()
                GraphLegend()
            }

            ModuleThreeGraph(
                xValue: 1.35,
                targetCase: .undefined,
                showsMovingPoint: true
            )
            .frame(height: 285)

            HStack(alignment: .top, spacing: 12) {
                Image(systemName: "eye.fill")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(AppTheme.softGold)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Look Around the Hole")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.softGold)

                    Text("Although no value is assigned at x = 2, the curve approaches y = 4 from both sides. Therefore, the limit can still exist.")
                        .font(.system(size: 12.5, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                        .lineSpacing(3)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(14)
            .background(AppTheme.gold.opacity(0.09))
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
    }
}

private struct GraphElementRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(AppTheme.lightBlue)
                .frame(width: 18)

            Text(text)
                .font(.system(size: 11.5, weight: .medium, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

private struct ExpressionBadge: View {
    let expression: String
    let caption: String

    var body: some View {
        VStack(spacing: 5) {
            Text(expression)
                .font(.system(size: 15, weight: .semibold, design: .serif))
                .foregroundStyle(AppTheme.warmWhite)
                .minimumScaleFactor(0.72)
                .lineLimit(1)

            Text(caption)
                .font(.system(size: 9.5, weight: .semibold, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(Color.white.opacity(0.055))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}
