import SwiftUI

struct ModuleSixIntroductionView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 890 {
                        HStack(alignment: .top, spacing: 27) {
                            explanationPanel
                                .frame(width: 360)
                            conditionsPanel
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            explanationPanel
                            conditionsPanel
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

    private var explanationPanel: some View {
        VStack(alignment: .leading, spacing: 15) {
            LessonEyebrow(text: "Screen 1 · Connect")

            Text("Continuity: Where Limit and Function Meet")
                .font(.system(size: 29, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text("Intuitively, a function is continuous if its graph can pass through the point without jumping or leaving a hole. Mathematically, we must verify three conditions, not merely check whether the curve looks connected.")
                .font(.system(size: 13.5, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            ModuleCard {
                VStack(spacing: 8) {
                    Text("CONTINUITY AT x = a")
                        .font(.system(size: 9.5, weight: .bold, design: .rounded))
                        .tracking(1.3)
                        .foregroundStyle(AppTheme.softGold)

                    Text("limₓ→ₐ f(x) = f(a)")
                        .font(.system(size: 25, weight: .semibold, design: .serif))
                        .foregroundStyle(AppTheme.warmWhite)

                    Text("This equality makes sense only after verifying that both sides exist.")
                        .font(.system(size: 11.5, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.mutedText)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity)
            }

            Text("If even one condition fails, the function is not continuous at that point. This does not make the entire function useless: the discontinuity may be located only at x = a.")
                .font(.system(size: 11.8, weight: .semibold, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)
                .lineSpacing(2)
                .fixedSize(horizontal: false, vertical: true)
                .padding(12)
                .background(AppTheme.lightBlue.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }

    private var conditionsPanel: some View {
        VStack(alignment: .leading, spacing: 13) {
            LessonEyebrow(text: "The Three Required Questions")

            IntroConditionCard(
                number: 1,
                title: "Does f(a) Exist?",
                expression: "f(a) must be defined",
                explanation: "Look for a filled point or a value assigned exactly at x = a.",
                color: AppTheme.lightBlue
            )

            IntroConditionCard(
                number: 2,
                title: "Does the Limit Exist?",
                expression: "limₓ→ₐ⁻ f(x) = limₓ→ₐ⁺ f(x)",
                explanation: "The approaches from the left and right must lead to the same number.",
                color: AppTheme.softGold
            )

            IntroConditionCard(
                number: 3,
                title: "Do They Match?",
                expression: "limₓ→ₐ f(x) = f(a)",
                explanation: "The value being approached must equal the value assigned to the function.",
                color: AppTheme.success
            )

            HStack(spacing: 9) {
                ContinuityPreviewPill(title: "Continuous", icon: "checkmark.circle.fill", color: AppTheme.success)
                ContinuityPreviewPill(title: "Hole", icon: "circle.dashed", color: AppTheme.softGold)
                ContinuityPreviewPill(title: "Jump", icon: "arrow.up.and.down.circle.fill", color: AppTheme.error)
            }
        }
    }
}

private struct IntroConditionCard: View {
    let number: Int
    let title: String
    let expression: String
    let explanation: String
    let color: Color

    var body: some View {
        HStack(alignment: .top, spacing: 13) {
            Text("\(number)")
                .font(.system(size: 12, weight: .black, design: .rounded))
                .foregroundStyle(AppTheme.deepNavy)
                .frame(width: 32, height: 32)
                .background(color)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundStyle(color)
                Text(expression)
                    .font(.system(size: 17, weight: .semibold, design: .serif))
                    .foregroundStyle(AppTheme.warmWhite)
                Text(explanation)
                    .font(.system(size: 10.8, weight: .medium, design: .rounded))
                    .foregroundStyle(AppTheme.mutedText)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)
        }
        .padding(14)
        .background(Color.white.opacity(0.055))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(color.opacity(0.2), lineWidth: 1)
        }
    }
}

private struct ContinuityPreviewPill: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        Label(title, systemImage: icon)
            .font(.system(size: 10.5, weight: .bold, design: .rounded))
            .foregroundStyle(color)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 9)
            .background(color.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}
