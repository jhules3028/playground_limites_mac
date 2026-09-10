import SwiftUI

struct ModuleFiveAssessmentView: View {
    @State private var firstAnswer: Int?
    @State private var secondAnswer: Int?

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading, spacing: 6) {
                            LessonEyebrow(text: "Screen 5 · Assess")
                            Text("Solve Two Limits")
                                .font(.system(size: 30, weight: .heavy, design: .rounded))
                                .foregroundStyle(AppTheme.warmWhite)
                        }

                        Spacer()

                        VStack(alignment: .trailing, spacing: 3) {
                            Text(scoreText)
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundStyle(answeredQuestions == 2 ? AppTheme.success : AppTheme.mutedText)
                            Text("First identify the method, then calculate.")
                                .font(.system(size: 10.5, design: .rounded))
                                .foregroundStyle(AppTheme.mutedText)
                        }
                    }

                    Group {
                        if geometry.size.width >= 890 {
                            HStack(alignment: .top, spacing: 22) {
                                firstExercise
                                    .frame(maxWidth: .infinity)
                                secondExercise
                                    .frame(maxWidth: .infinity)
                            }
                        } else {
                            VStack(spacing: 22) {
                                firstExercise
                                secondExercise
                            }
                        }
                    }

                    ModuleCard {
                        HStack(alignment: .top, spacing: 13) {
                            Image(systemName: "map.fill")
                                .font(.system(size: 19, weight: .bold))
                                .foregroundStyle(AppTheme.softGold)

                            VStack(alignment: .leading, spacing: 5) {
                                Text("Algebraic Path")
                                    .font(.system(size: 12, weight: .bold, design: .rounded))
                                    .foregroundStyle(AppTheme.softGold)

                                Text("1. Substitute.  2. If you obtain a number, stop.  3. If 0/0 appears, factor or rationalize.  4. Simplify and substitute again.")
                                    .font(.system(size: 12.3, weight: .semibold, design: .rounded))
                                    .foregroundStyle(AppTheme.warmWhite)
                                    .lineSpacing(2)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                }
                .frame(maxWidth: 1_040)
                .padding(.horizontal, 48)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var firstExercise: some View {
        ModuleCard {
            VStack(alignment: .leading, spacing: 10) {
                AssessmentHeading(number: 1, method: "DIRECT SUBSTITUTION", color: AppTheme.lightBlue)

                Text("Calculate  limₓ→₃ (2x² − x + 1)")
                    .font(.system(size: 19, weight: .semibold, design: .serif))
                    .foregroundStyle(AppTheme.warmWhite)
                    .minimumScaleFactor(0.72)
                    .lineLimit(1)

                Text("The expression is a polynomial, so you can substitute x = 3 directly.")
                    .font(.system(size: 11, weight: .medium, design: .rounded))
                    .foregroundStyle(AppTheme.mutedText)
                    .fixedSize(horizontal: false, vertical: true)

                HStack(spacing: 8) {
                    AssessmentNumberOption(value: "14", isSelected: firstAnswer == 0) { firstAnswer = 0 }
                    AssessmentNumberOption(value: "16", isSelected: firstAnswer == 1) { firstAnswer = 1 }
                    AssessmentNumberOption(value: "18", isSelected: firstAnswer == 2) { firstAnswer = 2 }
                }

                if let firstAnswer {
                    AlgebraFeedback(
                        isCorrect: firstAnswer == 1,
                        correctText: "Correct: 2(3²) − 3 + 1 = 18 − 3 + 1 = 16.",
                        incorrectText: "Substitute carefully: 3² = 9, then 2(9) − 3 + 1 = 16."
                    )
                }
            }
        }
    }

    private var secondExercise: some View {
        ModuleCard {
            VStack(alignment: .leading, spacing: 10) {
                AssessmentHeading(number: 2, method: "FACTORING", color: AppTheme.softGold)

                Text("Calculate  limₓ→₃ (x² − 9)/(x − 3)")
                    .font(.system(size: 19, weight: .semibold, design: .serif))
                    .foregroundStyle(AppTheme.warmWhite)
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)

                Text("Substitution produces 0/0. Use x² − 9 = (x − 3)(x + 3) and simplify.")
                    .font(.system(size: 11, weight: .medium, design: .rounded))
                    .foregroundStyle(AppTheme.mutedText)
                    .fixedSize(horizontal: false, vertical: true)

                HStack(spacing: 8) {
                    AssessmentNumberOption(value: "3", isSelected: secondAnswer == 0) { secondAnswer = 0 }
                    AssessmentNumberOption(value: "6", isSelected: secondAnswer == 1) { secondAnswer = 1 }
                    AssessmentNumberOption(value: "Does not exist", isSelected: secondAnswer == 2) { secondAnswer = 2 }
                }

                if let secondAnswer {
                    AlgebraFeedback(
                        isCorrect: secondAnswer == 1,
                        correctText: "Correct: it simplifies to x + 3, and substituting x = 3 gives 6.",
                        incorrectText: "0/0 is not the result. Cancel x − 3 for x ≠ 3 and evaluate x + 3."
                    )
                }
            }
        }
    }

    private var answeredQuestions: Int {
        (firstAnswer == nil ? 0 : 1) + (secondAnswer == nil ? 0 : 1)
    }

    private var correctAnswers: Int {
        (firstAnswer == 1 ? 1 : 0) + (secondAnswer == 1 ? 1 : 0)
    }

    private var scoreText: String {
        guard answeredQuestions > 0 else { return "2 exercises remaining" }
        return "\(correctAnswers) of \(answeredQuestions) correct"
    }
}

private struct AssessmentHeading: View {
    let number: Int
    let method: String
    let color: Color

    var body: some View {
        HStack {
            Text("EXERCISE \(number)")
            Spacer()
            Text(method)
        }
        .font(.system(size: 9.5, weight: .bold, design: .rounded))
        .tracking(1.1)
        .foregroundStyle(color)
    }
}

private struct AssessmentNumberOption: View {
    let value: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(value)
                .font(.system(size: value.count > 4 ? 11 : 16, weight: .bold, design: .monospaced))
                .foregroundStyle(isSelected ? AppTheme.deepNavy : AppTheme.warmWhite)
                .frame(maxWidth: .infinity)
                .frame(height: 42)
                .background(isSelected ? AppTheme.gold : Color.white.opacity(0.055))
                .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}
