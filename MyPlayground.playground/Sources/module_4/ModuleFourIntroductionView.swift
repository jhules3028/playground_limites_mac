import SwiftUI

struct ModuleFourIntroductionView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 880 {
                        HStack(alignment: .top, spacing: 28) {
                            explanationPanel
                                .frame(width: 350)
                            visualPanel
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            explanationPanel
                            visualPanel
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

    private var explanationPanel: some View {
        VStack(alignment: .leading, spacing: 15) {
            LessonEyebrow(text: "Pantalla 1 · Comprender")

            Text("Un punto, dos direcciones")
                .font(.system(size: 31, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text("Un límite lateral estudia qué ocurre desde un solo lado del punto objetivo. El signo pequeño indica la dirección de aproximación.")
                .font(.system(size: 13.5, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            LateralDefinitionCard(
                side: .left,
                expression: "limₓ→ₐ⁻ f(x)",
                description: "Usa valores menores que a y avanza hacia la derecha."
            )

            LateralDefinitionCard(
                side: .right,
                expression: "limₓ→ₐ⁺ f(x)",
                description: "Usa valores mayores que a y avanza hacia la izquierda."
            )
        }
    }

    private var visualPanel: some View {
        VStack(alignment: .leading, spacing: 13) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    LessonEyebrow(text: "Ejemplo con salto")
                    Text("Cada lado cuenta su propia historia")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                }

                Spacer()

                HStack(spacing: 12) {
                    DirectionLegend(color: AppTheme.lightBlue, text: "izquierda")
                    DirectionLegend(color: AppTheme.softGold, text: "derecha")
                }
            }

            ModuleFourGraph(comparison: .jump)
                .frame(height: 300)

            ModuleCard {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Función del ejemplo")
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .tracking(1.2)
                        .foregroundStyle(AppTheme.softGold)

                    HStack(spacing: 15) {
                        Text("f(x) =")
                            .font(.system(size: 18, weight: .semibold, design: .serif))
                            .foregroundStyle(AppTheme.warmWhite)

                        VStack(alignment: .leading, spacing: 5) {
                            Text("x + 1,   si x < 2")
                                .foregroundStyle(AppTheme.lightBlue)
                            Text("x + 3,   si x > 2")
                                .foregroundStyle(AppTheme.softGold)
                        }
                        .font(.system(size: 14, weight: .bold, design: .monospaced))

                        Spacer()
                    }

                    Text("Primero analizaremos cada dirección por separado; después decidiremos si existe el límite bilateral.")
                        .font(.system(size: 11.5, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.mutedText)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}

private struct DirectionLegend: View {
    let color: Color
    let text: String

    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(color)
                .frame(width: 9, height: 9)
            Text(text)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
        }
    }
}
