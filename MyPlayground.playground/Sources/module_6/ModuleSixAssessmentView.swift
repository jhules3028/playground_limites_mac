import SwiftUI

struct ModuleSixAssessmentView: View {
    @State private var firstAnswer: Int?
    @State private var secondAnswer: Int?

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading, spacing: 6) {
                            LessonEyebrow(text: "Screen 5 · Identify")
                            Text("Diagnose Continuity")
                                .font(.system(size: 29, weight: .heavy, design: .rounded))
                                .foregroundStyle(AppTheme.warmWhite)
                        }

                        Spacer()

                        Text(scoreText)
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                            .foregroundStyle(answeredQuestions == 2 ? AppTheme.success : AppTheme.mutedText)
                    }

                    Group {
                        if geometry.size.width >= 900 {
                            HStack(alignment: .top, spacing: 22) {
                                firstQuestion
                                    .frame(maxWidth: .infinity)
                                secondQuestion
                                    .frame(maxWidth: .infinity)
                            }
                        } else {
                            VStack(spacing: 22) {
                                firstQuestion
                                secondQuestion
                            }
                        }
                    }

                    ModuleCard {
                        HStack(alignment: .top, spacing: 13) {
                            Image(systemName: "list.number")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(AppTheme.softGold)

                            VStack(alignment: .leading, spacing: 5) {
                                Text("Checklist")
                                    .font(.system(size: 12, weight: .bold, design: .rounded))
                                    .foregroundStyle(AppTheme.softGold)
                                Text("Do not decide by appearance alone: verify f(a), compare the one-sided limits, and finally check whether the limit equals f(a).")
                                    .font(.system(size: 12.2, weight: .semibold, design: .rounded))
                                    .foregroundStyle(AppTheme.warmWhite)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
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

    private var firstQuestion: some View {
        ModuleCard {
            VStack(alignment: .leading, spacing: 9) {
                AssessmentLabel(number: 1, color: AppTheme.lightBlue)

                Text("The curve approaches 4 from both sides, but f(2) = 0. Which case is this?")
                    .font(.system(size: 14.5, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .fixedSize(horizontal: false, vertical: true)

                ModuleSixGraph(continuityCase: .removable)
                    .frame(height: 125)

                HStack(spacing: 7) {
                    ContinuityAnswerOption(text: "Continuous", isSelected: firstAnswer == 0) { firstAnswer = 0 }
                    ContinuityAnswerOption(text: "Removable", isSelected: firstAnswer == 1) { firstAnswer = 1 }
                    ContinuityAnswerOption(text: "Jump", isSelected: firstAnswer == 2) { firstAnswer = 2 }
                }

                if let firstAnswer {
                    ContinuityFeedback(
                        isCorrect: firstAnswer == 1,
                        correctText: "Correct. The limit equals 4, but f(2) = 0. Changing only f(2) to 4 would repair the function.",
                        incorrectText: "Both sides do agree at 4. The issue is that f(2) equals 0, so the discontinuity is removable."
                    )
                }
            }
        }
    }

    private var secondQuestion: some View {
        ModuleCard {
            VStack(alignment: .leading, spacing: 9) {
                AssessmentLabel(number: 2, color: AppTheme.softGold)

                Text("Suppose f(2) = 5, L⁻ = 3, and L⁺ = 5. Why is the function not continuous at x = 2?")
                    .font(.system(size: 14.5, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(spacing: 7) {
                    DetailedContinuityOption(text: "Because f(2) does not exist.", isSelected: secondAnswer == 0) { secondAnswer = 0 }
                    DetailedContinuityOption(text: "Because the two-sided limit does not exist.", isSelected: secondAnswer == 1) { secondAnswer = 1 }
                    DetailedContinuityOption(text: "Because every limit must equal zero.", isSelected: secondAnswer == 2) { secondAnswer = 2 }
                }

                HStack(spacing: 8) {
                    ContinuityFact(label: "f(2)", value: "5", color: AppTheme.success)
                    ContinuityFact(label: "L⁻", value: "3", color: AppTheme.lightBlue)
                    ContinuityFact(label: "L⁺", value: "5", color: AppTheme.softGold)
                }

                if let secondAnswer {
                    ContinuityFeedback(
                        isCorrect: secondAnswer == 1,
                        correctText: "Correct. Because 3 ≠ 5, the one-sided limits do not form a two-sided limit, so the second condition fails.",
                        incorrectText: "f(2) does exist and equals 5. The problem is that the one-sided limits are different."
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
        guard answeredQuestions > 0 else { return "2 cases remaining" }
        return "\(correctAnswers) of \(answeredQuestions) correct"
    }
}

private struct AssessmentLabel: View {
    let number: Int
    let color: Color

    var body: some View {
        Text("CASE \(number)")
            .font(.system(size: 9.5, weight: .bold, design: .rounded))
            .tracking(1.3)
            .foregroundStyle(color)
    }
}

private struct ContinuityAnswerOption: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 10.5, weight: .bold, design: .rounded))
                .foregroundStyle(isSelected ? AppTheme.deepNavy : AppTheme.warmWhite)
                .frame(maxWidth: .infinity)
                .frame(height: 36)
                .background(isSelected ? AppTheme.gold : Color.white.opacity(0.055))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

private struct DetailedContinuityOption: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 9) {
                Circle()
                    .fill(isSelected ? AppTheme.gold : Color.white.opacity(0.1))
                    .frame(width: 20, height: 20)
                    .overlay {
                        if isSelected {
                            Image(systemName: "checkmark")
                                .font(.system(size: 8, weight: .black))
                                .foregroundStyle(AppTheme.deepNavy)
                        }
                    }

                Text(text)
                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 10)
            .frame(height: 38)
            .background(Color.white.opacity(isSelected ? 0.1 : 0.045))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

private struct ContinuityFact: View {
    let label: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 2) {
            Text(label)
                .font(.system(size: 9.5, weight: .semibold, design: .serif))
                .foregroundStyle(AppTheme.mutedText)
            Text(value)
                .font(.system(size: 14, weight: .bold, design: .monospaced))
                .foregroundStyle(color)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 7)
        .background(Color.black.opacity(0.13))
        .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
    }
}

private struct ContinuityFeedback: View {
    let isCorrect: Bool
    let correctText: String
    let incorrectText: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundStyle(isCorrect ? AppTheme.success : AppTheme.error)
            Text(isCorrect ? correctText : incorrectText)
                .font(.system(size: 10.3, weight: .medium, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(9)
        .background((isCorrect ? AppTheme.success : AppTheme.error).opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}
