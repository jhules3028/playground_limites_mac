import SwiftUI

struct ModuleFiveDirectView: View {
    @State private var revealedSteps = 1

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 890 {
                        HStack(alignment: .top, spacing: 27) {
                            explanationPanel
                                .frame(width: 350)
                            examplePanel
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            explanationPanel
                            examplePanel
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

    private var explanationPanel: some View {
        VStack(alignment: .leading, spacing: 15) {
            LessonEyebrow(text: "Screen 1 · Substitute")

            Text("From Behavior to Calculation")
                .font(.system(size: 30, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text("So far, we have examined tables and graphs. Algebraic techniques let us find the exact limit, provided that we manipulate the expression carefully.")
                .font(.system(size: 13.5, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            ModuleCard {
                VStack(alignment: .leading, spacing: 10) {
                    Label("First Strategy", systemImage: "1.circle.fill")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.softGold)

                    Text("Substitute x = a directly.")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)

                    Text("If you obtain a real number and the expression is defined, that value is the limit. Polynomials, for example, are continuous and usually allow this procedure.")
                        .font(.system(size: 11.8, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.mutedText)
                        .lineSpacing(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                MethodReminder(icon: "checkmark.circle.fill", text: "Real number: finish the calculation.", color: AppTheme.success)
                MethodReminder(icon: "exclamationmark.triangle.fill", text: "Form 0/0: transform the expression.", color: AppTheme.softGold)
                MethodReminder(icon: "arrow.triangle.2.circlepath", text: "After transforming, substitute again.", color: AppTheme.lightBlue)
            }
        }
    }

    private var examplePanel: some View {
        VStack(alignment: .leading, spacing: 13) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    LessonEyebrow(text: "Guided Example")
                    Text("A Linear Function")
                        .font(.system(size: 23, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                }

                Spacer()

                Text("limₓ→₂ (3x + 1)")
                    .font(.system(size: 20, weight: .semibold, design: .serif))
                    .foregroundStyle(AppTheme.softGold)
            }

            ModuleCard {
                VStack(alignment: .leading, spacing: 15) {
                    AlgebraStepRow(
                        number: 1,
                        title: "Identify the Target Point",
                        expression: "x → 2",
                        explanation: "The value we will substitute into the expression is a = 2."
                    )

                    if revealedSteps >= 2 {
                        AlgebraStepRow(
                            number: 2,
                            title: "Substitute 2 for x",
                            expression: "3(2) + 1",
                            explanation: "The substitution does not create division by zero or another undefined expression.",
                            color: AppTheme.softGold
                        )
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }

                    if revealedSteps >= 3 {
                        AlgebraStepRow(
                            number: 3,
                            title: "Perform the Operations",
                            expression: "3(2) + 1 = 6 + 1 = 7",
                            explanation: "Because we obtained a real number, the procedure ends here.",
                            color: AppTheme.success
                        )
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }
            }

            Button(action: revealNextStep) {
                Label(
                    revealedSteps == 3 ? "Restart Procedure" : "Show the Next Step",
                    systemImage: revealedSteps == 3 ? "arrow.counterclockwise" : "arrow.down.circle.fill"
                )
                .font(.system(size: 12.5, weight: .bold, design: .rounded))
                .foregroundStyle(AppTheme.deepNavy)
                .frame(maxWidth: .infinity)
                .frame(height: 42)
                .background(AppTheme.gold)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            .buttonStyle(.plain)

            AlgebraFormulaCard(
                eyebrow: "Conclusion",
                expression: "limₓ→₂ (3x + 1) = 7",
                explanation: "The limit equals the function value at x = 2 because the linear expression is continuous at that point.",
                color: AppTheme.success
            )
        }
    }

    private func revealNextStep() {
        withAnimation(.easeInOut(duration: 0.28)) {
            revealedSteps = revealedSteps == 3 ? 1 : revealedSteps + 1
        }
    }
}

private struct MethodReminder: View {
    let icon: String
    let text: String
    let color: Color

    var body: some View {
        HStack(spacing: 9) {
            Image(systemName: icon)
                .foregroundStyle(color)
                .frame(width: 18)
            Text(text)
                .font(.system(size: 11.5, weight: .semibold, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)
        }
    }
}
