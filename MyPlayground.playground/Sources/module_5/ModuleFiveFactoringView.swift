import SwiftUI

struct ModuleFiveFactoringView: View {
    @State private var selectedStep: Int?

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 900 {
                        HStack(alignment: .top, spacing: 26) {
                            explanationPanel
                                .frame(width: 335)
                            procedurePanel
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            explanationPanel
                            procedurePanel
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

    private var explanationPanel: some View {
        VStack(alignment: .leading, spacing: 14) {
            LessonEyebrow(text: "Pantalla 3 · Factorizar")

            Text("Encuentra el factor que causa el hueco")
                .font(.system(size: 28, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text("La diferencia de cuadrados x² − 4 contiene el mismo factor x − 2 que aparece en el denominador. Al hacerlo visible podremos simplificar la expresión para valores cercanos a 2.")
                .font(.system(size: 13, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)

            AlgebraFormulaCard(
                eyebrow: "Problema",
                expression: "limₓ→₂ (x² − 4) / (x − 2)",
                explanation: "La sustitución directa produce 0/0, así que necesitamos transformar el numerador."
            )

            ModuleCard {
                VStack(alignment: .leading, spacing: 8) {
                    Label("Diferencia de cuadrados", systemImage: "square.grid.2x2.fill")
                        .font(.system(size: 11.5, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.lightBlue)

                    Text("A² − B² = (A − B)(A + B)")
                        .font(.system(size: 18, weight: .semibold, design: .serif))
                        .foregroundStyle(AppTheme.warmWhite)

                    Text("Aquí A = x y B = 2. Por eso x² − 4 = (x − 2)(x + 2).")
                        .font(.system(size: 11.5, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.mutedText)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }

    private var procedurePanel: some View {
        VStack(alignment: .leading, spacing: 12) {
            LessonEyebrow(text: "Elige y comprueba")

            ModuleCard {
                VStack(alignment: .leading, spacing: 9) {
                    Text("¿Cuál debe ser el siguiente paso después de obtener 0/0?")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)

                    HStack(spacing: 8) {
                        CompactAlgebraChoice(text: "Factorizar x² − 4", isSelected: selectedStep == 0) {
                            selectedStep = 0
                        }
                        CompactAlgebraChoice(text: "Dividir 0 entre 0", isSelected: selectedStep == 1) {
                            selectedStep = 1
                        }
                        CompactAlgebraChoice(text: "Promediar los términos", isSelected: selectedStep == 2) {
                            selectedStep = 2
                        }
                    }

                    if let selectedStep {
                        AlgebraFeedback(
                            isCorrect: selectedStep == 0,
                            correctText: "Exacto. Factorizar revela el término x − 2 que podemos simplificar.",
                            incorrectText: "La forma 0/0 no se opera ni se promedia. Primero debemos factorizar el numerador."
                        )
                    }
                }
            }

            ModuleCard {
                VStack(alignment: .leading, spacing: 12) {
                    AlgebraStepRow(
                        number: 1,
                        title: "Factoriza el numerador",
                        expression: "x² − 4 = (x − 2)(x + 2)",
                        explanation: "Aplicamos la identidad de diferencia de cuadrados."
                    )

                    AlgebraStepRow(
                        number: 2,
                        title: "Reescribe y simplifica",
                        expression: "[(x − 2)(x + 2)] / (x − 2) = x + 2",
                        explanation: "Cancelamos x − 2 únicamente para x ≠ 2. Eso es suficiente porque el límite estudia puntos cercanos.",
                        color: AppTheme.softGold
                    )

                    AlgebraStepRow(
                        number: 3,
                        title: "Sustituye en la expresión simplificada",
                        expression: "limₓ→₂ (x + 2) = 2 + 2 = 4",
                        explanation: "Ahora la sustitución produce un número real.",
                        color: AppTheme.success
                    )
                }
            }

            HStack(alignment: .top, spacing: 11) {
                Image(systemName: "info.circle.fill")
                    .foregroundStyle(AppTheme.lightBlue)
                Text("Simplificar no rellena el hueco de la función original. Sólo crea una fórmula equivalente alrededor de x = 2, que es justamente la información que necesita el límite.")
                    .font(.system(size: 11.5, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .lineSpacing(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(12)
            .background(AppTheme.lightBlue.opacity(0.085))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }
}

private struct CompactAlgebraChoice: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 10.5, weight: .bold, design: .rounded))
                .foregroundStyle(isSelected ? AppTheme.deepNavy : AppTheme.warmWhite)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, minHeight: 38)
                .padding(.horizontal, 7)
                .background(isSelected ? AppTheme.gold : Color.white.opacity(0.055))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}
