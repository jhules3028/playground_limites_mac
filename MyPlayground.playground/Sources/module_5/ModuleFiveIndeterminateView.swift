import SwiftUI

struct ModuleFiveIndeterminateView: View {
    @State private var selectedAnswer: Int?

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 890 {
                        HStack(alignment: .top, spacing: 27) {
                            meaningPanel
                                .frame(width: 360)
                            decisionPanel
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            meaningPanel
                            decisionPanel
                        }
                    }
                }
                .frame(maxWidth: 1_040)
                .padding(.horizontal, 48)
                .padding(.vertical, 9)
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var meaningPanel: some View {
        VStack(alignment: .leading, spacing: 15) {
            LessonEyebrow(text: "Screen 2 · Interpret")

            Text("What Does 0/0 Mean?")
                .font(.system(size: 30, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text("When x = 2 is substituted into the following quotient, the numerator and denominator become zero at the same time.")
                .font(.system(size: 13.5, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            AlgebraFormulaCard(
                eyebrow: "Initial Substitution",
                expression: "(2² − 4) / (2 − 2) = 0/0",
                explanation: "The original expression cannot be evaluated directly at x = 2.",
                color: AppTheme.softGold
            )

            ModuleCard {
                VStack(alignment: .leading, spacing: 10) {
                    Text("0/0 Is an Indeterminate Form")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.softGold)

                    Text("It does not mean that the limit is 0. Nor does it automatically mean that it is infinite or does not exist. It only tells us that direct substitution is not enough and that we need to reveal the expression's hidden behavior.")
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                        .lineSpacing(3)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }

    private var decisionPanel: some View {
        VStack(alignment: .leading, spacing: 14) {
            LessonEyebrow(text: "Concept Check")

            Text("The Signal Calls for a Transformation")
                .font(.system(size: 23, weight: .bold, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text("Our goal is not to assign a value to 0/0. We seek an equivalent expression for values near 2, even if a hole remains at the exact point.")
                .font(.system(size: 13, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)

            ModuleCard {
                VStack(alignment: .leading, spacing: 11) {
                    Text("After obtaining 0/0, which conclusion is correct?")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                        .fixedSize(horizontal: false, vertical: true)

                    AlgebraChoiceOption(label: "A", text: "The limit equals zero.", isSelected: selectedAnswer == 0) {
                        selectedAnswer = 0
                    }
                    AlgebraChoiceOption(label: "B", text: "We must transform the expression and continue.", isSelected: selectedAnswer == 1) {
                        selectedAnswer = 1
                    }
                    AlgebraChoiceOption(label: "C", text: "The limit never exists in these cases.", isSelected: selectedAnswer == 2) {
                        selectedAnswer = 2
                    }

                    if let selectedAnswer {
                        AlgebraFeedback(
                            isCorrect: selectedAnswer == 1,
                            correctText: "Correct. 0/0 is a signal to find another equivalent form before substituting again.",
                            incorrectText: "0/0 does not determine the result of the limit. It only indicates that direct substitution was insufficient."
                        )
                    }
                }
            }

            HStack(spacing: 12) {
                TransformationHint(icon: "function", title: "Polynomials", detail: "Try factoring.")
                TransformationHint(icon: "radical", title: "Roots", detail: "Look for the conjugate.")
            }

            Text("In the next example, x² − 4 is a difference of squares. That structure tells us that factoring is the appropriate path.")
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)
                .lineSpacing(2)
                .fixedSize(horizontal: false, vertical: true)
                .padding(13)
                .background(AppTheme.lightBlue.opacity(0.09))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }
}

private struct TransformationHint: View {
    let icon: String
    let title: String
    let detail: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(AppTheme.softGold)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 11.5, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                Text(detail)
                    .font(.system(size: 10.5, design: .rounded))
                    .foregroundStyle(AppTheme.mutedText)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Color.white.opacity(0.055))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}
