import SwiftUI

struct ModuleFiveRationalizationView: View {
    @State private var selectedConjugate: Int?

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 900 {
                        HStack(alignment: .top, spacing: 26) {
                            conceptPanel
                                .frame(width: 340)
                            solutionPanel
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            conceptPanel
                            solutionPanel
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

    private var conceptPanel: some View {
        VStack(alignment: .leading, spacing: 14) {
            LessonEyebrow(text: "Pantalla 4 · Racionalizar")

            Text("Cuando el obstáculo es una raíz")
                .font(.system(size: 28, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text("Si una raíz produce 0/0, podemos multiplicar por el conjugado. Esta operación crea una diferencia de cuadrados y elimina la resta problemática del numerador.")
                .font(.system(size: 13, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)

            AlgebraFormulaCard(
                eyebrow: "Ejemplo secundario",
                expression: "limₓ→₄ (√x − 2) / (x − 4)",
                explanation: "Sustituir x = 4 produce (2 − 2)/(4 − 4) = 0/0."
            )

            ModuleCard {
                VStack(alignment: .leading, spacing: 8) {
                    Text("¿Qué es el conjugado?")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.softGold)

                    Text("Se conserva cada término y sólo cambia el signo que los separa:")
                        .font(.system(size: 11.5, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.mutedText)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("√x − 2   ⟶   √x + 2")
                        .font(.system(size: 20, weight: .semibold, design: .serif))
                        .foregroundStyle(AppTheme.warmWhite)

                    Text("El producto (√x − 2)(√x + 2) se convierte en x − 4.")
                        .font(.system(size: 11.5, weight: .semibold, design: .rounded))
                        .foregroundStyle(AppTheme.lightBlue)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }

    private var solutionPanel: some View {
        VStack(alignment: .leading, spacing: 12) {
            LessonEyebrow(text: "Selecciona el conjugado")

            ModuleCard {
                VStack(alignment: .leading, spacing: 9) {
                    Text("¿Por cuál fracción equivalente a 1 debemos multiplicar?")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)

                    AlgebraChoiceOption(label: "A", text: "(√x + 2) / (√x + 2)", isSelected: selectedConjugate == 0) {
                        selectedConjugate = 0
                    }
                    AlgebraChoiceOption(label: "B", text: "(√x − 2) / (√x − 2)", isSelected: selectedConjugate == 1) {
                        selectedConjugate = 1
                    }
                    AlgebraChoiceOption(label: "C", text: "(x + 4) / (x + 4)", isSelected: selectedConjugate == 2) {
                        selectedConjugate = 2
                    }

                    if let selectedConjugate {
                        AlgebraFeedback(
                            isCorrect: selectedConjugate == 0,
                            correctText: "Correcto. √x + 2 es el conjugado de √x − 2 y permite formar x − 4.",
                            incorrectText: "Necesitamos cambiar el signo entre √x y 2. El conjugado correcto es √x + 2."
                        )
                    }
                }
            }

            ModuleCard {
                VStack(alignment: .leading, spacing: 11) {
                    AlgebraStepRow(
                        number: 1,
                        title: "Multiplica por el conjugado",
                        expression: "[(√x − 2)/(x − 4)] · [(√x + 2)/(√x + 2)]",
                        explanation: "La segunda fracción vale 1, así que no alteramos el valor de la expresión."
                    )

                    AlgebraStepRow(
                        number: 2,
                        title: "Usa la diferencia de cuadrados",
                        expression: "(x − 4) / [(x − 4)(√x + 2)]",
                        explanation: "El producto del numerador se convierte en x − 4.",
                        color: AppTheme.softGold
                    )

                    AlgebraStepRow(
                        number: 3,
                        title: "Simplifica y sustituye",
                        expression: "1/(√x + 2) ⟶ 1/(2 + 2) = 1/4",
                        explanation: "Después de cancelar x − 4 para x ≠ 4, la sustitución ya es válida.",
                        color: AppTheme.success
                    )
                }
            }

        }
    }
}
