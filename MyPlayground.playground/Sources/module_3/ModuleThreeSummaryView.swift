import SwiftUI

struct ModuleThreeSummaryView: View {
    @State private var selectedAnswer: Int?

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 880 {
                        HStack(alignment: .top, spacing: 26) {
                            comparisonPanel
                                .frame(maxWidth: .infinity)
                            checkpointPanel
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            comparisonPanel
                            checkpointPanel
                        }
                    }
                }
                .frame(maxWidth: 1_040)
                .padding(.horizontal, 48)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var comparisonPanel: some View {
        VStack(alignment: .leading, spacing: 15) {
            LessonEyebrow(text: "Pantalla 3 · Diferenciar")

            Text("Límite y valor de la función")
                .font(.system(size: 29, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            HStack(spacing: 12) {
                Text("FUNCIÓN DEL CASO")
                    .font(.system(size: 9, weight: .bold, design: .rounded))
                    .tracking(1.2)
                    .foregroundStyle(AppTheme.lightBlue)

                Text("f(x) =  x + 2, si x ≠ 2;   6, si x = 2")
                    .font(.system(size: 15, weight: .semibold, design: .serif))
                    .foregroundStyle(AppTheme.warmWhite)
                    .minimumScaleFactor(0.72)
                    .lineLimit(1)
            }
            .padding(.horizontal, 13)
            .frame(maxWidth: .infinity, minHeight: 42, alignment: .leading)
            .background(AppTheme.lightBlue.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(AppTheme.lightBlue.opacity(0.2), lineWidth: 1)
            }

            HStack(spacing: 11) {
                MeaningCard(
                    expression: "limₓ→₂ f(x) = 4",
                    label: "LÍMITE",
                    explanation: "Describe la tendencia alrededor de x = 2.",
                    color: AppTheme.softGold
                )

                MeaningCard(
                    expression: "f(2) = 6",
                    label: "VALOR EXACTO",
                    explanation: "Describe solamente el punto ubicado en x = 2.",
                    color: AppTheme.error
                )
            }

            ModuleThreeGraph(xValue: 2, targetCase: .different, showsMovingPoint: false)
                .frame(height: 215)

            HStack(alignment: .top, spacing: 10) {
                Image(systemName: "lightbulb.fill")
                    .foregroundStyle(AppTheme.softGold)
                Text("Mover o cambiar un solo punto puede modificar f(2), pero no altera la tendencia de toda la curva cercana.")
                    .font(.system(size: 11.5, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private var checkpointPanel: some View {
        VStack(alignment: .leading, spacing: 15) {
            LessonEyebrow(text: "Comprobación rápida")

            ModuleCard {
                VStack(alignment: .leading, spacing: 12) {
                    Text("La gráfica tiene un hueco en (2, 4) y un punto lleno en (2, 6). ¿Qué afirmación es correcta?")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                        .fixedSize(horizontal: false, vertical: true)

                    GraphAnswerOption(label: "A", text: "El límite es 4 y f(2) = 6.", isSelected: selectedAnswer == 0) {
                        selectedAnswer = 0
                    }

                    GraphAnswerOption(label: "B", text: "El límite y f(2) valen 6.", isSelected: selectedAnswer == 1) {
                        selectedAnswer = 1
                    }

                    GraphAnswerOption(label: "C", text: "El límite no existe por el hueco.", isSelected: selectedAnswer == 2) {
                        selectedAnswer = 2
                    }

                    if let selectedAnswer {
                        GraphFeedback(isCorrect: selectedAnswer == 0)
                    }
                }
            }

            ModuleCard {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Idea clave del módulo")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.softGold)

                    Text("limₓ→ₐ f(x) estudia valores cercanos a a; f(a) pregunta qué ocurre exactamente en a. No son la misma pregunta.")
                        .font(.system(size: 13.5, weight: .semibold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                        .lineSpacing(3)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}

private struct MeaningCard: View {
    let expression: String
    let label: String
    let explanation: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(label)
                .font(.system(size: 9, weight: .bold, design: .rounded))
                .tracking(1.2)
                .foregroundStyle(color)

            Text(expression)
                .font(.system(size: 16, weight: .semibold, design: .serif))
                .foregroundStyle(AppTheme.warmWhite)
                .lineLimit(1)
                .minimumScaleFactor(0.7)

            Text(explanation)
                .font(.system(size: 10.5, weight: .medium, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, minHeight: 88, alignment: .topLeading)
        .padding(13)
        .background(color.opacity(0.09))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(color.opacity(0.22), lineWidth: 1)
        }
    }
}

private struct GraphAnswerOption: View {
    let label: String
    let text: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 11) {
                Text(label)
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundStyle(isSelected ? AppTheme.deepNavy : AppTheme.softGold)
                    .frame(width: 29, height: 29)
                    .background(isSelected ? AppTheme.gold : AppTheme.gold.opacity(0.1))
                    .clipShape(Circle())

                Text(text)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
            .padding(10)
            .background(Color.white.opacity(isSelected ? 0.11 : 0.05))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(isSelected ? AppTheme.gold.opacity(0.75) : Color.white.opacity(0.08), lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
    }
}

private struct GraphFeedback: View {
    let isCorrect: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 9) {
            Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundStyle(isCorrect ? AppTheme.success : AppTheme.error)

            Text(
                isCorrect
                    ? "Correcto. La curva se aproxima a 4, mientras el punto lleno indica que f(2) = 6."
                    : "Observa cada marca por separado: el hueco en y = 4 representa el límite y el punto lleno en y = 6 representa f(2)."
            )
            .font(.system(size: 11, weight: .medium, design: .rounded))
            .foregroundStyle(AppTheme.warmWhite)
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(11)
        .background((isCorrect ? AppTheme.success : AppTheme.error).opacity(0.11))
        .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
    }
}
