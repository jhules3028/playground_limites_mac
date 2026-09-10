import SwiftUI

struct ModuleTwoSummaryView: View {
    @State private var selectedAnswer: Int?

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 870 {
                        HStack(alignment: .top, spacing: 26) {
                            conclusionPanel
                                .frame(maxWidth: .infinity)
                            checkpointPanel
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            conclusionPanel
                            checkpointPanel
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

    private var conclusionPanel: some View {
        VStack(alignment: .leading, spacing: 18) {
            LessonEyebrow(text: "Pantalla 3 · Interpretar")

            Text("De los datos a la conclusión")
                .font(.system(size: 32, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            ModuleCard {
                VStack(spacing: 14) {
                    HStack(spacing: 10) {
                        TrendColumn(title: "x → 2⁻", values: ["1.9", "1.99", "1.999"], color: AppTheme.lightBlue)

                        Image(systemName: "arrow.right")
                            .foregroundStyle(AppTheme.gold)

                        TrendColumn(title: "f(x) → 4", values: ["3.9", "3.99", "3.999"], color: AppTheme.success)
                    }

                    Rectangle()
                        .fill(Color.white.opacity(0.11))
                        .frame(height: 1)

                    HStack(spacing: 10) {
                        TrendColumn(title: "x → 2⁺", values: ["2.1", "2.01", "2.001"], color: AppTheme.softGold)

                        Image(systemName: "arrow.right")
                            .foregroundStyle(AppTheme.gold)

                        TrendColumn(title: "f(x) → 4", values: ["4.1", "4.01", "4.001"], color: AppTheme.success)
                    }
                }
            }

            ModuleCard {
                VStack(spacing: 9) {
                    Text("Por la izquierda y por la derecha")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.mutedText)

                    Text("limₓ→₂  (x² − 4) / (x − 2) = 4")
                        .font(.system(size: 25, weight: .semibold, design: .serif))
                        .foregroundStyle(AppTheme.warmWhite)
                        .minimumScaleFactor(0.72)

                    Text("Los dos grupos de resultados apuntan al mismo número.")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.success)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var checkpointPanel: some View {
        VStack(alignment: .leading, spacing: 18) {
            LessonEyebrow(text: "Comprobación rápida")

            ModuleCard {
                VStack(alignment: .leading, spacing: 14) {
                    Text("Según la tabla, ¿cuál es la conclusión correcta?")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                        .fixedSize(horizontal: false, vertical: true)

                    ConclusionOption(
                        label: "A",
                        text: "El límite es 4.",
                        isSelected: selectedAnswer == 0
                    ) {
                        selectedAnswer = 0
                    }

                    ConclusionOption(
                        label: "B",
                        text: "f(2) = 4 porque la tabla lo demuestra.",
                        isSelected: selectedAnswer == 1
                    ) {
                        selectedAnswer = 1
                    }

                    ConclusionOption(
                        label: "C",
                        text: "El límite no existe porque no usamos x = 2.",
                        isSelected: selectedAnswer == 2
                    ) {
                        selectedAnswer = 2
                    }

                    if let selectedAnswer {
                        FeedbackPanel(isCorrect: selectedAnswer == 0)
                    }
                }
            }

            ModuleCard {
                HStack(alignment: .top, spacing: 14) {
                    Image(systemName: "lightbulb.fill")
                        .font(.system(size: 19, weight: .bold))
                        .foregroundStyle(AppTheme.softGold)

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Idea clave")
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundStyle(AppTheme.softGold)

                        Text("La tabla aporta evidencia de aproximación. No asegura que la función esté definida exactamente en el punto objetivo.")
                            .font(.system(size: 13.5, weight: .semibold, design: .rounded))
                            .foregroundStyle(AppTheme.warmWhite)
                            .lineSpacing(3)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
    }
}

private struct TrendColumn: View {
    let title: String
    let values: [String]
    let color: Color

    var body: some View {
        VStack(spacing: 7) {
            Text(title)
                .font(.system(size: 12, weight: .bold, design: .serif))
                .foregroundStyle(color)

            Text(values.joined(separator: "  ·  "))
                .font(.system(size: 10.5, weight: .semibold, design: .monospaced))
                .foregroundStyle(AppTheme.warmWhite)
                .minimumScaleFactor(0.7)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct ConclusionOption: View {
    let label: String
    let text: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Text(label)
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundStyle(isSelected ? AppTheme.deepNavy : AppTheme.softGold)
                    .frame(width: 30, height: 30)
                    .background(isSelected ? AppTheme.gold : AppTheme.gold.opacity(0.1))
                    .clipShape(Circle())

                Text(text)
                    .font(.system(size: 12.5, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
            .padding(11)
            .background(Color.white.opacity(isSelected ? 0.11 : 0.05))
            .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 13, style: .continuous)
                    .stroke(isSelected ? AppTheme.gold.opacity(0.75) : Color.white.opacity(0.08), lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
    }
}

private struct FeedbackPanel: View {
    let isCorrect: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundStyle(isCorrect ? AppTheme.success : AppTheme.error)

            Text(
                isCorrect
                    ? "Correcto. Los resultados de ambos lados se acercan a 4, por eso la evidencia numérica indica que el límite es 4."
                    : "Revisa la diferencia entre límite y valor de la función: la expresión original produce 0/0 en x = 2, pero los valores cercanos sí se aproximan a 4."
            )
            .font(.system(size: 11.5, weight: .medium, design: .rounded))
            .foregroundStyle(AppTheme.warmWhite)
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(12)
        .background((isCorrect ? AppTheme.success : AppTheme.error).opacity(0.11))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}
