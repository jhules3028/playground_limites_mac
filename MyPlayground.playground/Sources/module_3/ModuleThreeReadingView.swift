import SwiftUI

struct ModuleThreeReadingView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 880 {
                        HStack(alignment: .top, spacing: 28) {
                            explanationPanel
                                .frame(width: 325)
                            graphPanel
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            explanationPanel
                            graphPanel
                        }
                    }
                }
                .frame(maxWidth: 1_040)
                .padding(.horizontal, 48)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var explanationPanel: some View {
        VStack(alignment: .leading, spacing: 16) {
            LessonEyebrow(text: "Pantalla 1 · Leer")

            Text("El límite visto en una gráfica")
                .font(.system(size: 31, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text("La gráfica permite observar la tendencia de f(x) cuando x se acerca al punto objetivo a.")
                .font(.system(size: 14, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            ModuleCard {
                VStack(alignment: .leading, spacing: 11) {
                    GraphElementRow(icon: "arrow.left.and.right", text: "Los ejes ubican los valores de x y de y.")
                    GraphElementRow(icon: "waveform.path.ecg", text: "La curva muestra el comportamiento de la función.")
                    GraphElementRow(icon: "scope", text: "Las guías doradas señalan a = 2 y L = 4.")
                    GraphElementRow(icon: "circle", text: "El hueco indica que f(2) no está definida.")
                }
            }

            HStack(spacing: 10) {
                ExpressionBadge(expression: "limₓ→₂ f(x) = 4", caption: "comportamiento cercano")
                ExpressionBadge(expression: "f(2)", caption: "valor exacto")
            }
        }
    }

    private var graphPanel: some View {
        VStack(alignment: .leading, spacing: 13) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    LessonEyebrow(text: "Ejemplo visual")
                    Text("Acercarse no significa llegar")
                        .font(.system(size: 23, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                }

                Spacer()
                GraphLegend()
            }

            ModuleThreeGraph(
                xValue: 1.35,
                targetCase: .undefined,
                showsMovingPoint: true
            )
            .frame(height: 285)

            HStack(alignment: .top, spacing: 12) {
                Image(systemName: "eye.fill")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(AppTheme.softGold)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Mira alrededor del hueco")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.softGold)

                    Text("Aunque no hay un valor colocado en x = 2, la curva se acerca a y = 4 desde ambos lados. Por eso el límite sí puede existir.")
                        .font(.system(size: 12.5, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                        .lineSpacing(3)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(14)
            .background(AppTheme.gold.opacity(0.09))
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
    }
}

private struct GraphElementRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(AppTheme.lightBlue)
                .frame(width: 18)

            Text(text)
                .font(.system(size: 11.5, weight: .medium, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

private struct ExpressionBadge: View {
    let expression: String
    let caption: String

    var body: some View {
        VStack(spacing: 5) {
            Text(expression)
                .font(.system(size: 15, weight: .semibold, design: .serif))
                .foregroundStyle(AppTheme.warmWhite)
                .minimumScaleFactor(0.72)
                .lineLimit(1)

            Text(caption)
                .font(.system(size: 9.5, weight: .semibold, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(Color.white.opacity(0.055))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}
