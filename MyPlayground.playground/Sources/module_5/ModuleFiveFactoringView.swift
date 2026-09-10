import SwiftUI

struct ModuleFiveFactoringView: View {
    @State private var selectedStep: Int?

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 900 {
                        HStack(alignment: .top, spacing: 26) {
                            explanationPanel
                                .frame(width: 335)
                            procedurePanel
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            explanationPanel
                            procedurePanel
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
        VStack(alignment: .leading, spacing: 14) {
            LessonEyebrow(text: "Screen 3 · Factor")

            Text("Find the Factor That Causes the Hole")
                .font(.system(size: 28, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text("The difference of squares x² − 4 contains the same factor x − 2 that appears in the denominator. Revealing it lets us simplify the expression for values near 2.")
                .font(.system(size: 13, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)

            AlgebraFormulaCard(
                eyebrow: "Problem",
                expression: "limₓ→₂ (x² − 4) / (x − 2)",
                explanation: "Direct substitution produces 0/0, so we need to transform the numerator."
            )

            ModuleCard {
                VStack(alignment: .leading, spacing: 8) {
                    Label("Difference of Squares", systemImage: "square.grid.2x2.fill")
                        .font(.system(size: 11.5, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.lightBlue)

                    Text("A² − B² = (A − B)(A + B)")
                        .font(.system(size: 18, weight: .semibold, design: .serif))
                        .foregroundStyle(AppTheme.warmWhite)

                    Text("Here A = x and B = 2. Therefore, x² − 4 = (x − 2)(x + 2).")
                        .font(.system(size: 11.5, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.mutedText)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }

    private var procedurePanel: some View {
        VStack(alignment: .leading, spacing: 12) {
            LessonEyebrow(text: "Choose and Check")

            ModuleCard {
                VStack(alignment: .leading, spacing: 9) {
                    Text("What should the next step be after obtaining 0/0?")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)

                    HStack(spacing: 8) {
                        CompactAlgebraChoice(text: "Factor x² − 4", isSelected: selectedStep == 0) {
                            selectedStep = 0
                        }
                        CompactAlgebraChoice(text: "Divide 0 by 0", isSelected: selectedStep == 1) {
                            selectedStep = 1
                        }
                        CompactAlgebraChoice(text: "Average the terms", isSelected: selectedStep == 2) {
                            selectedStep = 2
                        }
                    }

                    if let selectedStep {
                        AlgebraFeedback(
                            isCorrect: selectedStep == 0,
                            correctText: "Exactly. Factoring reveals the x − 2 term that we can simplify.",
                            incorrectText: "The form 0/0 cannot be calculated or averaged. First, we must factor the numerator."
                        )
                    }
                }
            }

            ModuleCard {
                VStack(alignment: .leading, spacing: 12) {
                    AlgebraStepRow(
                        number: 1,
                        title: "Factor the Numerator",
                        expression: "x² − 4 = (x − 2)(x + 2)",
                        explanation: "We apply the difference-of-squares identity."
                    )

                    AlgebraStepRow(
                        number: 2,
                        title: "Rewrite and Simplify",
                        expression: "[(x − 2)(x + 2)] / (x − 2) = x + 2",
                        explanation: "We cancel x − 2 only for x ≠ 2. That is sufficient because a limit examines nearby points.",
                        color: AppTheme.softGold
                    )

                    AlgebraStepRow(
                        number: 3,
                        title: "Substitute into the Simplified Expression",
                        expression: "limₓ→₂ (x + 2) = 2 + 2 = 4",
                        explanation: "Now the substitution produces a real number.",
                        color: AppTheme.success
                    )
                }
            }

            HStack(alignment: .top, spacing: 11) {
                Image(systemName: "info.circle.fill")
                    .foregroundStyle(AppTheme.lightBlue)
                Text("Simplifying does not fill the hole in the original function. It only creates an equivalent formula around x = 2, which is exactly the information the limit needs.")
                    .font(.system(size: 11.5, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .lineSpacing(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(12)
            .background(AppTheme.lightBlue.opacity(0.085))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }
}

private struct CompactAlgebraChoice: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 10.5, weight: .bold, design: .rounded))
                .foregroundStyle(isSelected ? AppTheme.deepNavy : AppTheme.warmWhite)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, minHeight: 38)
                .padding(.horizontal, 7)
                .background(isSelected ? AppTheme.gold : Color.white.opacity(0.055))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}
