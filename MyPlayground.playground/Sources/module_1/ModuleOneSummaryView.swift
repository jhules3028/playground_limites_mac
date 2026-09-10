import SwiftUI

struct ModuleOneSummaryView: View {
    @State private var selectedAnswer: Bool?

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 860 {
                        HStack(alignment: .top, spacing: 26) {
                            summaryColumn
                                .frame(maxWidth: .infinity)
                            checkpointColumn
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            summaryColumn
                            checkpointColumn
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

    private var summaryColumn: some View {
        VStack(alignment: .leading, spacing: 18) {
            LessonEyebrow(text: "Screen 3 · Review")

            Text("What You Should Remember")
                .font(.system(size: 34, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            VStack(spacing: 11) {
                KeyIdeaRow(
                    number: "01",
                    title: "x approaches a",
                    explanation: "We examine values of x around the target point."
                )
                KeyIdeaRow(
                    number: "02",
                    title: "f(x) approaches L",
                    explanation: "The outputs show a trend toward the limit value."
                )
                KeyIdeaRow(
                    number: "03",
                    title: "Reaching is not required",
                    explanation: "The limit may exist even when the function is undefined at a."
                )
            }

            ModuleCard {
                HStack(spacing: 18) {
                    VStack(spacing: 4) {
                        Text("x")
                            .foregroundStyle(AppTheme.lightBlue)
                        Text("→ a")
                            .foregroundStyle(AppTheme.warmWhite)
                    }

                    Image(systemName: "arrow.right")
                        .foregroundStyle(AppTheme.gold)

                    VStack(spacing: 4) {
                        Text("f(x)")
                            .foregroundStyle(AppTheme.softGold)
                        Text("→ L")
                            .foregroundStyle(AppTheme.warmWhite)
                    }
                }
                .font(.system(size: 24, weight: .bold, design: .serif))
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var checkpointColumn: some View {
        VStack(alignment: .leading, spacing: 18) {
            LessonEyebrow(text: "Quick check")

            ModuleCard {
                VStack(alignment: .leading, spacing: 18) {
                    HStack(spacing: 10) {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(size: 19, weight: .bold))
                            .foregroundStyle(AppTheme.softGold)

                        Text("Before You Continue")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundStyle(AppTheme.warmWhite)
                    }

                    Text("Can the limit of a function exist as x approaches a even if f(a) is undefined?")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                        .fixedSize(horizontal: false, vertical: true)

                    HStack(spacing: 12) {
                        AnswerButton(
                            title: "Yes",
                            isSelected: selectedAnswer == true,
                            color: AppTheme.success
                        ) {
                            selectedAnswer = true
                        }

                        AnswerButton(
                            title: "No",
                            isSelected: selectedAnswer == false,
                            color: AppTheme.error
                        ) {
                            selectedAnswer = false
                        }
                    }

                    if let selectedAnswer {
                        HStack(alignment: .top, spacing: 11) {
                            Image(systemName: selectedAnswer ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundStyle(selectedAnswer ? AppTheme.success : AppTheme.error)

                            Text(
                                selectedAnswer
                                    ? "Correct. A limit depends on values near a; it does not require f(a) to exist."
                                    : "Not yet. Remember the hole in the example: f(2) does not exist, but nearby values approach 4."
                            )
                            .font(.system(size: 12.5, weight: .medium, design: .rounded))
                            .foregroundStyle(AppTheme.warmWhite)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(13)
                        .background((selectedAnswer ? AppTheme.success : AppTheme.error).opacity(0.11))
                        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                    }
                }
            }

            ModuleCard {
                HStack(alignment: .top, spacing: 15) {
                    Image(systemName: "quote.opening")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(AppTheme.softGold)

                    VStack(alignment: .leading, spacing: 7) {
                        Text("Key Idea from This Module")
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundStyle(AppTheme.softGold)

                        Text("A limit describes the value a function approaches, even if the function never actually takes that value.")
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .foregroundStyle(AppTheme.warmWhite)
                            .lineSpacing(4)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }

            Text("When you finish, you will continue with numerical representations using tables.")
                .font(.system(size: 11.5, weight: .medium, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
        }
    }
}

private struct KeyIdeaRow: View {
    let number: String
    let title: String
    let explanation: String

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Text(number)
                .font(.system(size: 11, weight: .bold, design: .monospaced))
                .foregroundStyle(AppTheme.softGold)
                .frame(width: 36, height: 36)
                .background(AppTheme.gold.opacity(0.12))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)

                Text(explanation)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(AppTheme.mutedText)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()
        }
        .padding(14)
        .background(Color.white.opacity(0.055))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}

private struct AnswerButton: View {
    let title: String
    let isSelected: Bool
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(isSelected ? AppTheme.deepNavy : AppTheme.warmWhite)
                .frame(maxWidth: .infinity)
                .frame(height: 42)
                .background(isSelected ? color : Color.white.opacity(0.07))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(isSelected ? color : Color.white.opacity(0.11), lineWidth: 1)
                }
        }
        .buttonStyle(.plain)
    }
}
