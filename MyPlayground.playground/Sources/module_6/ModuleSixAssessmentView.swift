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
                            LessonEyebrow(text: "Pantalla 5 · Identificar")
                            Text("Diagnostica la continuidad")
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
                                Text("Lista de comprobación")
                                    .font(.system(size: 12, weight: .bold, design: .rounded))
                                    .foregroundStyle(AppTheme.softGold)
                                Text("No decidas por la apariencia solamente: verifica f(a), compara los límites laterales y finalmente comprueba si el límite coincide con f(a).")
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

                Text("La curva se aproxima a 4 por ambos lados, pero f(2) = 0. ¿Qué caso es?")
                    .font(.system(size: 14.5, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .fixedSize(horizontal: false, vertical: true)

                ModuleSixGraph(continuityCase: .removable)
                    .frame(height: 125)

                HStack(spacing: 7) {
                    ContinuityAnswerOption(text: "Continua", isSelected: firstAnswer == 0) { firstAnswer = 0 }
                    ContinuityAnswerOption(text: "Removible", isSelected: firstAnswer == 1) { firstAnswer = 1 }
                    ContinuityAnswerOption(text: "Salto", isSelected: firstAnswer == 2) { firstAnswer = 2 }
                }

                if let firstAnswer {
                    ContinuityFeedback(
                        isCorrect: firstAnswer == 1,
                        correctText: "Correcto. El límite vale 4, pero f(2) = 0. Cambiar sólo f(2) a 4 repararía la función.",
                        incorrectText: "Los dos lados sí coinciden en 4. La falla es que f(2) vale 0, por eso la discontinuidad es removible."
                    )
                }
            }
        }
    }

    private var secondQuestion: some View {
        ModuleCard {
            VStack(alignment: .leading, spacing: 9) {
                AssessmentLabel(number: 2, color: AppTheme.softGold)

                Text("Se sabe que f(2) = 5, L⁻ = 3 y L⁺ = 5. ¿Por qué no es continua en x = 2?")
                    .font(.system(size: 14.5, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(spacing: 7) {
                    DetailedContinuityOption(text: "Porque f(2) no existe.", isSelected: secondAnswer == 0) { secondAnswer = 0 }
                    DetailedContinuityOption(text: "Porque el límite bilateral no existe.", isSelected: secondAnswer == 1) { secondAnswer = 1 }
                    DetailedContinuityOption(text: "Porque todo límite debe valer cero.", isSelected: secondAnswer == 2) { secondAnswer = 2 }
                }

                HStack(spacing: 8) {
                    ContinuityFact(label: "f(2)", value: "5", color: AppTheme.success)
                    ContinuityFact(label: "L⁻", value: "3", color: AppTheme.lightBlue)
                    ContinuityFact(label: "L⁺", value: "5", color: AppTheme.softGold)
                }

                if let secondAnswer {
                    ContinuityFeedback(
                        isCorrect: secondAnswer == 1,
                        correctText: "Correcto. Como 3 ≠ 5, los laterales no forman un límite bilateral y falla la segunda condición.",
                        incorrectText: "f(2) sí existe y vale 5. El problema es que los límites laterales son diferentes."
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
        guard answeredQuestions > 0 else { return "2 casos pendientes" }
        return "\(correctAnswers) de \(answeredQuestions) correctos"
    }
}

private struct AssessmentLabel: View {
    let number: Int
    let color: Color

    var body: some View {
        Text("CASO \(number)")
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
