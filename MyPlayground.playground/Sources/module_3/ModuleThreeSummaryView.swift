import SwiftUI

struct ModuleThreeSummaryView: View {
    @State private var selectedAnswer: Int?

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 880 {
                        HStack(alignment: .top, spacing: 26) {
                            comparisonPanel
                                .frame(maxWidth: .infinity)
                            checkpointPanel
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            comparisonPanel
                            checkpointPanel
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

    private var comparisonPanel: some View {
        VStack(alignment: .leading, spacing: 15) {
            LessonEyebrow(text: "Screen 3 · Distinguish")

            Text("Limit and Function Value")
                .font(.system(size: 29, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            HStack(spacing: 12) {
                Text("FUNCTION DEFINITION")
                    .font(.system(size: 9, weight: .bold, design: .rounded))
                    .tracking(1.2)
                    .foregroundStyle(AppTheme.lightBlue)

                Text("f(x) =  x + 2, if x ≠ 2;   6, if x = 2")
                    .font(.system(size: 15, weight: .semibold, design: .serif))
                    .foregroundStyle(AppTheme.warmWhite)
                    .minimumScaleFactor(0.72)
                    .lineLimit(1)
            }
            .padding(.horizontal, 13)
            .frame(maxWidth: .infinity, minHeight: 42, alignment: .leading)
            .background(AppTheme.lightBlue.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(AppTheme.lightBlue.opacity(0.2), lineWidth: 1)
            }

            HStack(spacing: 11) {
                MeaningCard(
                    expression: "limₓ→₂ f(x) = 4",
                    label: "LIMIT",
                    explanation: "Describes the trend around x = 2.",
                    color: AppTheme.softGold
                )

                MeaningCard(
                    expression: "f(2) = 6",
                    label: "EXACT VALUE",
                    explanation: "Describes only the point located at x = 2.",
                    color: AppTheme.error
                )
            }

            ModuleThreeGraph(xValue: 2, targetCase: .different, showsMovingPoint: false)
                .frame(height: 215)

            HStack(alignment: .top, spacing: 10) {
                Image(systemName: "lightbulb.fill")
                    .foregroundStyle(AppTheme.softGold)
                Text("Moving or changing one point can modify f(2), but it does not alter the trend of the entire nearby curve.")
                    .font(.system(size: 11.5, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private var checkpointPanel: some View {
        VStack(alignment: .leading, spacing: 15) {
            LessonEyebrow(text: "Quick check")

            ModuleCard {
                VStack(alignment: .leading, spacing: 12) {
                    Text("The graph has a hole at (2, 4) and a filled point at (2, 6). Which statement is correct?")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                        .fixedSize(horizontal: false, vertical: true)

                    GraphAnswerOption(label: "A", text: "The limit is 4 and f(2) = 6.", isSelected: selectedAnswer == 0) {
                        selectedAnswer = 0
                    }

                    GraphAnswerOption(label: "B", text: "The limit and f(2) both equal 6.", isSelected: selectedAnswer == 1) {
                        selectedAnswer = 1
                    }

                    GraphAnswerOption(label: "C", text: "The limit does not exist because of the hole.", isSelected: selectedAnswer == 2) {
                        selectedAnswer = 2
                    }

                    if let selectedAnswer {
                        GraphFeedback(isCorrect: selectedAnswer == 0)
                    }
                }
            }

            ModuleCard {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Key Idea from This Module")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.softGold)

                    Text("limₓ→ₐ f(x) examines values near a; f(a) asks what happens exactly at a. They are not the same question.")
                        .font(.system(size: 13.5, weight: .semibold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                        .lineSpacing(3)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}

private struct MeaningCard: View {
    let expression: String
    let label: String
    let explanation: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(label)
                .font(.system(size: 9, weight: .bold, design: .rounded))
                .tracking(1.2)
                .foregroundStyle(color)

            Text(expression)
                .font(.system(size: 16, weight: .semibold, design: .serif))
                .foregroundStyle(AppTheme.warmWhite)
                .lineLimit(1)
                .minimumScaleFactor(0.7)

            Text(explanation)
                .font(.system(size: 10.5, weight: .medium, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, minHeight: 88, alignment: .topLeading)
        .padding(13)
        .background(color.opacity(0.09))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(color.opacity(0.22), lineWidth: 1)
        }
    }
}

private struct GraphAnswerOption: View {
    let label: String
    let text: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 11) {
                Text(label)
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundStyle(isSelected ? AppTheme.deepNavy : AppTheme.softGold)
                    .frame(width: 29, height: 29)
                    .background(isSelected ? AppTheme.gold : AppTheme.gold.opacity(0.1))
                    .clipShape(Circle())

                Text(text)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
            .padding(10)
            .background(Color.white.opacity(isSelected ? 0.11 : 0.05))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(isSelected ? AppTheme.gold.opacity(0.75) : Color.white.opacity(0.08), lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
    }
}

private struct GraphFeedback: View {
    let isCorrect: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 9) {
            Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundStyle(isCorrect ? AppTheme.success : AppTheme.error)

            Text(
                isCorrect
                    ? "Correct. The curve approaches 4, while the filled point indicates that f(2) = 6."
                    : "Read each mark separately: the hole at y = 4 represents the limit, and the filled point at y = 6 represents f(2)."
            )
            .font(.system(size: 11, weight: .medium, design: .rounded))
            .foregroundStyle(AppTheme.warmWhite)
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(11)
        .background((isCorrect ? AppTheme.success : AppTheme.error).opacity(0.11))
        .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
    }
}
