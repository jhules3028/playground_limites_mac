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
                            LessonEyebrow(text: "Pantalla 5 · Evaluar")
                            Text("Resuelve dos límites")
                                .font(.system(size: 30, weight: .heavy, design: .rounded))
                                .foregroundStyle(AppTheme.warmWhite)
                        }

                        Spacer()

                        VStack(alignment: .trailing, spacing: 3) {
                            Text(scoreText)
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundStyle(answeredQuestions == 2 ? AppTheme.success : AppTheme.mutedText)
                            Text("Primero identifica el método y después calcula.")
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
                                Text("Ruta algebraica")
                                    .font(.system(size: 12, weight: .bold, design: .rounded))
                                    .foregroundStyle(AppTheme.softGold)

                                Text("1. Sustituye.  2. Si obtienes un número, termina.  3. Si aparece 0/0, factoriza o racionaliza.  4. Simplifica y sustituye nuevamente.")
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
                AssessmentHeading(number: 1, method: "SUSTITUCIÓN DIRECTA", color: AppTheme.lightBlue)

                Text("Calcula  limₓ→₃ (2x² − x + 1)")
                    .font(.system(size: 19, weight: .semibold, design: .serif))
                    .foregroundStyle(AppTheme.warmWhite)
                    .minimumScaleFactor(0.72)
                    .lineLimit(1)

                Text("La expresión es un polinomio, así que puedes sustituir x = 3 directamente.")
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
                        correctText: "Correcto: 2(3²) − 3 + 1 = 18 − 3 + 1 = 16.",
                        incorrectText: "Sustituye con cuidado: 3² = 9, luego 2(9) − 3 + 1 = 16."
                    )
                }
            }
        }
    }

    private var secondExercise: some View {
        ModuleCard {
            VStack(alignment: .leading, spacing: 10) {
                AssessmentHeading(number: 2, method: "FACTORIZACIÓN", color: AppTheme.softGold)

                Text("Calcula  limₓ→₃ (x² − 9)/(x − 3)")
                    .font(.system(size: 19, weight: .semibold, design: .serif))
                    .foregroundStyle(AppTheme.warmWhite)
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)

                Text("La sustitución produce 0/0. Usa x² − 9 = (x − 3)(x + 3) y simplifica.")
                    .font(.system(size: 11, weight: .medium, design: .rounded))
                    .foregroundStyle(AppTheme.mutedText)
                    .fixedSize(horizontal: false, vertical: true)

                HStack(spacing: 8) {
                    AssessmentNumberOption(value: "3", isSelected: secondAnswer == 0) { secondAnswer = 0 }
                    AssessmentNumberOption(value: "6", isSelected: secondAnswer == 1) { secondAnswer = 1 }
                    AssessmentNumberOption(value: "No existe", isSelected: secondAnswer == 2) { secondAnswer = 2 }
                }

                if let secondAnswer {
                    AlgebraFeedback(
                        isCorrect: secondAnswer == 1,
                        correctText: "Correcto: se simplifica a x + 3 y al sustituir x = 3 obtenemos 6.",
                        incorrectText: "0/0 no es el resultado. Cancela x − 3 para x ≠ 3 y evalúa x + 3."
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
        guard answeredQuestions > 0 else { return "2 ejercicios pendientes" }
        return "\(correctAnswers) de \(answeredQuestions) correctos"
    }
}

private struct AssessmentHeading: View {
    let number: Int
    let method: String
    let color: Color

    var body: some View {
        HStack {
            Text("EJERCICIO \(number)")
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
