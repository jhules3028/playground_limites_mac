import SwiftUI

struct ModuleFourPracticeView: View {
    @State private var firstAnswer: Int?
    @State private var secondAnswer: Int?

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 17) {
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading, spacing: 6) {
                            LessonEyebrow(text: "Pantalla 5 · Comprobar")
                            Text("Pon a prueba los dos lados")
                                .font(.system(size: 30, weight: .heavy, design: .rounded))
                                .foregroundStyle(AppTheme.warmWhite)
                        }

                        Spacer()

                        Text(scoreText)
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                            .foregroundStyle(answeredQuestions == 2 ? AppTheme.success : AppTheme.mutedText)
                    }

                    Group {
                        if geometry.size.width >= 880 {
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
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(AppTheme.softGold)

                            VStack(alignment: .leading, spacing: 5) {
                                Text("Antes de concluir")
                                    .font(.system(size: 12, weight: .bold, design: .rounded))
                                    .foregroundStyle(AppTheme.softGold)

                                Text("Calcula el límite izquierdo, calcula el derecho y compáralos. Sólo si coinciden puedes afirmar que existe el límite bilateral.")
                                    .font(.system(size: 12.5, weight: .semibold, design: .rounded))
                                    .foregroundStyle(AppTheme.warmWhite)
                                    .lineSpacing(2)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
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

    private var firstQuestion: some View {
        ModuleCard {
            VStack(alignment: .leading, spacing: 11) {
                QuestionNumberBadge(number: 1, color: AppTheme.lightBlue)

                Text("¿Qué indica el signo menos en x → a⁻?")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .fixedSize(horizontal: false, vertical: true)

                LateralAnswerOption(text: "x toma valores menores que a.", isSelected: firstAnswer == 0) {
                    firstAnswer = 0
                }
                LateralAnswerOption(text: "Los resultados siempre son negativos.", isSelected: firstAnswer == 1) {
                    firstAnswer = 1
                }
                LateralAnswerOption(text: "La función disminuye obligatoriamente.", isSelected: firstAnswer == 2) {
                    firstAnswer = 2
                }

                if let firstAnswer {
                    LateralFeedback(
                        isCorrect: firstAnswer == 0,
                        correctText: "Correcto. Nos acercamos usando valores ubicados a la izquierda de a.",
                        incorrectText: "El signo describe una dirección, no el signo del resultado ni si la función crece o disminuye."
                    )
                }
            }
        }
    }

    private var secondQuestion: some View {
        ModuleCard {
            VStack(alignment: .leading, spacing: 11) {
                QuestionNumberBadge(number: 2, color: AppTheme.softGold)

                Text("Si L⁻ = 2 y L⁺ = 5, ¿qué ocurre con limₓ→ₐ f(x)?")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .fixedSize(horizontal: false, vertical: true)

                LateralAnswerOption(text: "Existe y vale 3.5.", isSelected: secondAnswer == 0) {
                    secondAnswer = 0
                }
                LateralAnswerOption(text: "Existe y vale 5.", isSelected: secondAnswer == 1) {
                    secondAnswer = 1
                }
                LateralAnswerOption(text: "No existe porque los lados difieren.", isSelected: secondAnswer == 2) {
                    secondAnswer = 2
                }

                if let secondAnswer {
                    LateralFeedback(
                        isCorrect: secondAnswer == 2,
                        correctText: "Correcto. Dos límites laterales diferentes impiden que exista el límite bilateral.",
                        incorrectText: "No se promedian ni se elige uno. Para existir, los dos límites laterales deben coincidir."
                    )
                }
            }
        }
    }

    private var answeredQuestions: Int {
        (firstAnswer == nil ? 0 : 1) + (secondAnswer == nil ? 0 : 1)
    }

    private var correctAnswers: Int {
        (firstAnswer == 0 ? 1 : 0) + (secondAnswer == 2 ? 1 : 0)
    }

    private var scoreText: String {
        guard answeredQuestions > 0 else { return "Responde 2 preguntas" }
        return "\(correctAnswers) de \(answeredQuestions) correctas"
    }
}

private struct QuestionNumberBadge: View {
    let number: Int
    let color: Color

    var body: some View {
        Text("PREGUNTA \(number)")
            .font(.system(size: 9.5, weight: .bold, design: .rounded))
            .tracking(1.3)
            .foregroundStyle(color)
    }
}

private struct LateralAnswerOption: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Circle()
                    .fill(isSelected ? AppTheme.gold : Color.white.opacity(0.1))
                    .frame(width: 22, height: 22)
                    .overlay {
                        if isSelected {
                            Image(systemName: "checkmark")
                                .font(.system(size: 9, weight: .black))
                                .foregroundStyle(AppTheme.deepNavy)
                        }
                    }

                Text(text)
                    .font(.system(size: 11.5, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
            .padding(10)
            .background(Color.white.opacity(isSelected ? 0.1 : 0.045))
            .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 11, style: .continuous)
                    .stroke(isSelected ? AppTheme.gold.opacity(0.7) : Color.white.opacity(0.07), lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
    }
}

private struct LateralFeedback: View {
    let isCorrect: Bool
    let correctText: String
    let incorrectText: String

    var body: some View {
        HStack(alignment: .top, spacing: 9) {
            Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundStyle(isCorrect ? AppTheme.success : AppTheme.error)

            Text(isCorrect ? correctText : incorrectText)
                .font(.system(size: 10.5, weight: .medium, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(10)
        .background((isCorrect ? AppTheme.success : AppTheme.error).opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}
