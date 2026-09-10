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
            LessonEyebrow(text: "Pantalla 1 · Sustituir")

            Text("Del comportamiento al cálculo")
                .font(.system(size: 30, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text("Hasta ahora observamos tablas y gráficas. El cálculo algebraico permite obtener el límite exactamente, siempre que manipulemos la expresión con cuidado.")
                .font(.system(size: 13.5, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            ModuleCard {
                VStack(alignment: .leading, spacing: 10) {
                    Label("Primera estrategia", systemImage: "1.circle.fill")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.softGold)

                    Text("Sustituye directamente x = a.")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)

                    Text("Si obtienes un número real y la expresión está definida, ese valor es el límite. Los polinomios, por ejemplo, son continuos y normalmente permiten este procedimiento.")
                        .font(.system(size: 11.8, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.mutedText)
                        .lineSpacing(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                MethodReminder(icon: "checkmark.circle.fill", text: "Número real: termina el cálculo.", color: AppTheme.success)
                MethodReminder(icon: "exclamationmark.triangle.fill", text: "Forma 0/0: transforma la expresión.", color: AppTheme.softGold)
                MethodReminder(icon: "arrow.triangle.2.circlepath", text: "Después de transformar, sustituye otra vez.", color: AppTheme.lightBlue)
            }
        }
    }

    private var examplePanel: some View {
        VStack(alignment: .leading, spacing: 13) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    LessonEyebrow(text: "Ejemplo guiado")
                    Text("Una función lineal")
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
                        title: "Identifica el punto objetivo",
                        expression: "x → 2",
                        explanation: "El valor que sustituiremos en la expresión es a = 2."
                    )

                    if revealedSteps >= 2 {
                        AlgebraStepRow(
                            number: 2,
                            title: "Sustituye x por 2",
                            expression: "3(2) + 1",
                            explanation: "La sustitución no crea una división entre cero ni otra expresión indefinida.",
                            color: AppTheme.softGold
                        )
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }

                    if revealedSteps >= 3 {
                        AlgebraStepRow(
                            number: 3,
                            title: "Realiza las operaciones",
                            expression: "3(2) + 1 = 6 + 1 = 7",
                            explanation: "Como obtuvimos un número real, el procedimiento termina aquí.",
                            color: AppTheme.success
                        )
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }
            }

            Button(action: revealNextStep) {
                Label(
                    revealedSteps == 3 ? "Reiniciar procedimiento" : "Mostrar el siguiente paso",
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
                eyebrow: "Conclusión",
                expression: "limₓ→₂ (3x + 1) = 7",
                explanation: "El límite coincide con el valor de la función en x = 2 porque la expresión lineal es continua en ese punto.",
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
