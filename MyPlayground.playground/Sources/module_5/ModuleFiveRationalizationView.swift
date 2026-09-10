import SwiftUI

struct ModuleFiveRationalizationView: View {
    @State private var selectedConjugate: Int?

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 900 {
                        HStack(alignment: .top, spacing: 26) {
                            conceptPanel
                                .frame(width: 340)
                            solutionPanel
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            conceptPanel
                            solutionPanel
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

    private var conceptPanel: some View {
        VStack(alignment: .leading, spacing: 14) {
            LessonEyebrow(text: "Screen 4 · Rationalize")

            Text("When a Root Is the Obstacle")
                .font(.system(size: 28, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text("If a root produces 0/0, we can multiply by the conjugate. This operation creates a difference of squares and removes the problematic subtraction from the numerator.")
                .font(.system(size: 13, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)

            AlgebraFormulaCard(
                eyebrow: "Additional Example",
                expression: "limₓ→₄ (√x − 2) / (x − 4)",
                explanation: "Substituting x = 4 produces (2 − 2)/(4 − 4) = 0/0."
            )

            ModuleCard {
                VStack(alignment: .leading, spacing: 8) {
                    Text("What Is the Conjugate?")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.softGold)

                    Text("Keep each term and change only the sign between them:")
                        .font(.system(size: 11.5, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.mutedText)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("√x − 2   ⟶   √x + 2")
                        .font(.system(size: 20, weight: .semibold, design: .serif))
                        .foregroundStyle(AppTheme.warmWhite)

                    Text("The product (√x − 2)(√x + 2) becomes x − 4.")
                        .font(.system(size: 11.5, weight: .semibold, design: .rounded))
                        .foregroundStyle(AppTheme.lightBlue)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }

    private var solutionPanel: some View {
        VStack(alignment: .leading, spacing: 12) {
            LessonEyebrow(text: "Select the Conjugate")

            ModuleCard {
                VStack(alignment: .leading, spacing: 9) {
                    Text("Which fraction equal to 1 should we multiply by?")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)

                    AlgebraChoiceOption(label: "A", text: "(√x + 2) / (√x + 2)", isSelected: selectedConjugate == 0) {
                        selectedConjugate = 0
                    }
                    AlgebraChoiceOption(label: "B", text: "(√x − 2) / (√x − 2)", isSelected: selectedConjugate == 1) {
                        selectedConjugate = 1
                    }
                    AlgebraChoiceOption(label: "C", text: "(x + 4) / (x + 4)", isSelected: selectedConjugate == 2) {
                        selectedConjugate = 2
                    }

                    if let selectedConjugate {
                        AlgebraFeedback(
                            isCorrect: selectedConjugate == 0,
                            correctText: "Correct. √x + 2 is the conjugate of √x − 2 and lets us form x − 4.",
                            incorrectText: "We need to change the sign between √x and 2. The correct conjugate is √x + 2."
                        )
                    }
                }
            }

            ModuleCard {
                VStack(alignment: .leading, spacing: 11) {
                    AlgebraStepRow(
                        number: 1,
                        title: "Multiply by the Conjugate",
                        expression: "[(√x − 2)/(x − 4)] · [(√x + 2)/(√x + 2)]",
                        explanation: "The second fraction equals 1, so we do not change the value of the expression."
                    )

                    AlgebraStepRow(
                        number: 2,
                        title: "Use the Difference of Squares",
                        expression: "(x − 4) / [(x − 4)(√x + 2)]",
                        explanation: "The product in the numerator becomes x − 4.",
                        color: AppTheme.softGold
                    )

                    AlgebraStepRow(
                        number: 3,
                        title: "Simplify and Substitute",
                        expression: "1/(√x + 2) ⟶ 1/(2 + 2) = 1/4",
                        explanation: "After canceling x − 4 for x ≠ 4, substitution is now valid.",
                        color: AppTheme.success
                    )
                }
            }

        }
    }
}
