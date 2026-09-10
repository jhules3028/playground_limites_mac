import SwiftUI

struct ModuleFiveIndeterminateView: View {
    @State private var selectedAnswer: Int?

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 890 {
                        HStack(alignment: .top, spacing: 27) {
                            meaningPanel
                                .frame(width: 360)
                            decisionPanel
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            meaningPanel
                            decisionPanel
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

    private var meaningPanel: some View {
        VStack(alignment: .leading, spacing: 15) {
            LessonEyebrow(text: "Pantalla 2 · Interpretar")

            Text("¿Qué significa obtener 0/0?")
                .font(.system(size: 30, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text("Al sustituir x = 2 en el cociente siguiente, el numerador y el denominador se hacen cero al mismo tiempo.")
                .font(.system(size: 13.5, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            AlgebraFormulaCard(
                eyebrow: "Sustitución inicial",
                expression: "(2² − 4) / (2 − 2) = 0/0",
                explanation: "La expresión original no puede evaluarse directamente en x = 2.",
                color: AppTheme.softGold
            )

            ModuleCard {
                VStack(alignment: .leading, spacing: 10) {
                    Text("0/0 es una forma indeterminada")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.softGold)

                    Text("No significa que el límite sea 0. Tampoco significa automáticamente que sea infinito o que no exista. Sólo nos avisa que la sustitución directa no basta y que necesitamos revelar el comportamiento oculto de la expresión.")
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                        .lineSpacing(3)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }

    private var decisionPanel: some View {
        VStack(alignment: .leading, spacing: 14) {
            LessonEyebrow(text: "Pausa conceptual")

            Text("La señal pide una transformación")
                .font(.system(size: 23, weight: .bold, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text("Nuestro objetivo no es asignarle un valor a 0/0. Buscamos una expresión equivalente para los valores cercanos a 2, aunque en el punto exacto siga existiendo un hueco.")
                .font(.system(size: 13, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)

            ModuleCard {
                VStack(alignment: .leading, spacing: 11) {
                    Text("Después de obtener 0/0, ¿qué conclusión es correcta?")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                        .fixedSize(horizontal: false, vertical: true)

                    AlgebraChoiceOption(label: "A", text: "El límite es igual a cero.", isSelected: selectedAnswer == 0) {
                        selectedAnswer = 0
                    }
                    AlgebraChoiceOption(label: "B", text: "Debemos transformar la expresión y continuar.", isSelected: selectedAnswer == 1) {
                        selectedAnswer = 1
                    }
                    AlgebraChoiceOption(label: "C", text: "El límite no existe en todos los casos.", isSelected: selectedAnswer == 2) {
                        selectedAnswer = 2
                    }

                    if let selectedAnswer {
                        AlgebraFeedback(
                            isCorrect: selectedAnswer == 1,
                            correctText: "Correcto. 0/0 es una señal para buscar otra forma equivalente antes de volver a sustituir.",
                            incorrectText: "0/0 no determina el resultado del límite. Sólo indica que la sustitución directa fue insuficiente."
                        )
                    }
                }
            }

            HStack(spacing: 12) {
                TransformationHint(icon: "function", title: "Polinomios", detail: "Intenta factorizar.")
                TransformationHint(icon: "radical", title: "Raíces", detail: "Busca el conjugado.")
            }

            Text("En el siguiente ejemplo, x² − 4 es una diferencia de cuadrados. Esa estructura nos indica que la factorización será el camino adecuado.")
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)
                .lineSpacing(2)
                .fixedSize(horizontal: false, vertical: true)
                .padding(13)
                .background(AppTheme.lightBlue.opacity(0.09))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }
}

private struct TransformationHint: View {
    let icon: String
    let title: String
    let detail: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(AppTheme.softGold)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 11.5, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                Text(detail)
                    .font(.system(size: 10.5, design: .rounded))
                    .foregroundStyle(AppTheme.mutedText)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Color.white.opacity(0.055))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}
