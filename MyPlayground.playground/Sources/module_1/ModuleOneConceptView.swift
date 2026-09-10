import SwiftUI

struct ModuleOneConceptView: View {
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 840 {
                        HStack(alignment: .top, spacing: 28) {
                            definitionColumn
                                .frame(maxWidth: .infinity)
                            conceptColumn
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            definitionColumn
                            conceptColumn
                        }
                    }
                }
                .frame(maxWidth: 1_040)
                .padding(.horizontal, 48)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var definitionColumn: some View {
        VStack(alignment: .leading, spacing: 18) {
            LessonEyebrow(text: "Pantalla 1 · Comprender")

            Text("¿Qué es un límite?")
                .font(.system(size: 38, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text("Un límite describe el valor al que se aproxima una función cuando la variable independiente se acerca a un punto objetivo.")
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(5)
                .fixedSize(horizontal: false, vertical: true)

            ModuleCard {
                VStack(spacing: 13) {
                    Text("limₓ→ₐ  f(x) = L")
                        .font(.system(size: 34, weight: .semibold, design: .serif))
                        .foregroundStyle(AppTheme.warmWhite)

                    Rectangle()
                        .fill(AppTheme.gold.opacity(0.55))
                        .frame(height: 1)

                    Text("Cuando x se acerca a a, los valores de f(x) se acercan a L.")
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.softGold)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
            }

            ModuleCard {
                VStack(alignment: .leading, spacing: 12) {
                    Label("Piensa en acercarte a una puerta", systemImage: "figure.walk")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)

                    Text("Cada paso reduce la distancia: 1 m, ½ m, ¼ m, ⅛ m… Tu posición se aproxima a la puerta, aunque decidieras no tocarla.")
                        .font(.system(size: 12.5, design: .rounded))
                        .foregroundStyle(AppTheme.mutedText)
                        .fixedSize(horizontal: false, vertical: true)

                    ApproachAnalogyView()
                        .frame(height: 100)
                }
            }
        }
    }

    private var conceptColumn: some View {
        VStack(alignment: .leading, spacing: 18) {
            LessonEyebrow(text: "Conceptos esenciales")

            Text("Las piezas de la idea")
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            LazyVGrid(columns: columns, spacing: 12) {
                ConceptTile(
                    symbol: "x",
                    title: "Variable independiente",
                    explanation: "Es el valor que controlamos y acercamos al objetivo."
                )

                ConceptTile(
                    symbol: "a",
                    title: "Valor objetivo",
                    explanation: "Es el punto al que se aproxima x."
                )

                ConceptTile(
                    symbol: "→",
                    title: "Aproximación",
                    explanation: "Indica acercamiento; no obliga a llegar exactamente."
                )

                ConceptTile(
                    symbol: "L",
                    title: "Valor límite",
                    explanation: "Es el valor al que se aproximan los resultados de f(x)."
                )
            }

            ModuleCard {
                HStack(alignment: .top, spacing: 15) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(AppTheme.softGold)

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Idea clave")
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                            .foregroundStyle(AppTheme.softGold)

                        Text("Nos interesa el comportamiento alrededor del punto, no solamente lo que ocurre exactamente en él.")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundStyle(AppTheme.warmWhite)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
    }
}
