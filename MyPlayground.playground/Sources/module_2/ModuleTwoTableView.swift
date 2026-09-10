import SwiftUI

struct ModuleTwoTableView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 880 {
                        HStack(alignment: .top, spacing: 28) {
                            introduction
                                .frame(width: 315)
                            tablePanel
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            introduction
                            tablePanel
                        }
                    }
                }
                .frame(maxWidth: 1_040)
                .padding(.horizontal, 48)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var introduction: some View {
        VStack(alignment: .leading, spacing: 18) {
            LessonEyebrow(text: "Screen 1 · Observe")

            Text("Reading a Limit with Numbers")
                .font(.system(size: 32, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text("A table lets us examine what happens around the target point without substituting it directly.")
                .font(.system(size: 14, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            ModuleCard {
                VStack(spacing: 10) {
                    Text("limₓ→₂  (x² − 4) / (x − 2)")
                        .font(.system(size: 24, weight: .semibold, design: .serif))
                        .foregroundStyle(AppTheme.warmWhite)
                        .minimumScaleFactor(0.75)

                    Rectangle()
                        .fill(AppTheme.gold.opacity(0.5))
                        .frame(height: 1)

                    Text("Target point: a = 2")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.softGold)
                }
                .frame(maxWidth: .infinity)
            }

            ModuleCard {
                VStack(alignment: .leading, spacing: 10) {
                    SideLegend(color: AppTheme.lightBlue, title: "From the left", detail: "Values less than 2")
                    SideLegend(color: AppTheme.softGold, title: "From the right", detail: "Values greater than 2")
                }
            }
        }
    }

    private var tablePanel: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    LessonEyebrow(text: "Approaching from both sides")
                    Text("Where Are the Outputs Heading?")
                        .font(.system(size: 23, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                }

                Spacer()

                Text("x is never exactly 2")
                    .font(.system(size: 10, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppTheme.mutedText)
            }

            NumericalLimitTable(highlightedPrecision: nil)

            HStack(alignment: .top, spacing: 12) {
                Image(systemName: "arrow.down.to.line.compact")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(AppTheme.success)

                VStack(alignment: .leading, spacing: 5) {
                    Text("Observe the Pattern")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.success)

                    Text("3.9, 3.99, and 3.999 approach 4 from below; 4.1, 4.01, and 4.001 approach 4 from above.")
                        .font(.system(size: 12.5, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(15)
            .background(AppTheme.success.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
    }
}

private struct SideLegend: View {
    let color: Color
    let title: String
    let detail: String

    var body: some View {
        HStack(spacing: 11) {
            Circle()
                .fill(color)
                .frame(width: 10, height: 10)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                Text(detail)
                    .font(.system(size: 10.5, design: .rounded))
                    .foregroundStyle(AppTheme.mutedText)
            }
        }
    }
}
