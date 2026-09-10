import SwiftUI

struct ModuleTwoPrecisionView: View {
    @State private var precision = 1

    private var selectedRow: NumericalLimitRow {
        ModuleTwoExample.row(for: precision)
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading, spacing: 7) {
                            LessonEyebrow(text: "Pantalla 2 · Experimentar")
                            Text("Aumenta la precisión")
                                .font(.system(size: 32, weight: .heavy, design: .rounded))
                                .foregroundStyle(AppTheme.warmWhite)
                        }

                        Spacer()

                        Text("Cada decimal divide por 10 la distancia a x = 2")
                            .font(.system(size: 11.5, weight: .medium, design: .rounded))
                            .foregroundStyle(AppTheme.mutedText)
                    }

                    Group {
                        if geometry.size.width >= 880 {
                            HStack(alignment: .top, spacing: 24) {
                                controlsPanel
                                    .frame(width: 290)
                                resultsPanel
                                    .frame(maxWidth: .infinity)
                            }
                        } else {
                            VStack(spacing: 22) {
                                controlsPanel
                                resultsPanel
                            }
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

    private var controlsPanel: some View {
        VStack(alignment: .leading, spacing: 15) {
            ModuleCard {
                VStack(alignment: .leading, spacing: 14) {
                    Text("Elige cuántos decimales usar")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)

                    PrecisionSelector(precision: $precision)
                }
            }

            ModuleCard {
                VStack(spacing: 12) {
                    Text("distancia hasta a")
                        .font(.system(size: 10, weight: .semibold, design: .rounded))
                        .foregroundStyle(AppTheme.mutedText)

                    Text(ModuleTwoExample.distanceDescription(for: precision))
                        .font(.system(size: 32, weight: .bold, design: .monospaced))
                        .foregroundStyle(AppTheme.softGold)

                    HStack(spacing: 5) {
                        ForEach(1...3, id: \.self) { step in
                            Capsule()
                                .fill(step <= precision ? AppTheme.gold : Color.white.opacity(0.09))
                                .frame(height: 7)
                        }
                    }

                    Text(precisionMessage)
                        .font(.system(size: 11.5, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.mutedText)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var resultsPanel: some View {
        ModuleCard {
            VStack(spacing: 15) {
                HStack(spacing: 10) {
                    Text("FUNCIÓN ANALIZADA")
                        .font(.system(size: 9.5, weight: .bold, design: .rounded))
                        .tracking(1.3)
                        .foregroundStyle(AppTheme.softGold)

                    Spacer()

                    Text("f(x) = (x² − 4) / (x − 2),  x ≠ 2")
                        .font(.system(size: 16, weight: .semibold, design: .serif))
                        .foregroundStyle(AppTheme.warmWhite)
                        .minimumScaleFactor(0.75)
                        .lineLimit(1)
                }

                HStack(spacing: 12) {
                    ApproachValueCard(
                        direction: "IZQUIERDA",
                        arrow: "→",
                        xValue: ModuleTwoExample.format(selectedRow.leftX, precision: precision),
                        result: ModuleTwoExample.format(selectedRow.leftResult, precision: precision),
                        color: AppTheme.lightBlue
                    )

                    Image(systemName: "arrow.left.and.right")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(AppTheme.softGold)

                    ApproachValueCard(
                        direction: "DERECHA",
                        arrow: "←",
                        xValue: ModuleTwoExample.format(selectedRow.rightX, precision: precision),
                        result: ModuleTwoExample.format(selectedRow.rightResult, precision: precision),
                        color: AppTheme.softGold
                    )
                }

                NumericalLimitTable(highlightedPrecision: precision)

                HStack(spacing: 10) {
                    Image(systemName: "equal.circle.fill")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(AppTheme.success)

                    Text("Por ambos lados, f(x) se aproxima a 4.")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)

                    Spacer()

                    Text("L = 4")
                        .font(.system(size: 17, weight: .bold, design: .serif))
                        .foregroundStyle(AppTheme.success)
                }
                .padding(12)
                .background(AppTheme.success.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
        }
    }

    private var precisionMessage: String {
        switch precision {
        case 1:
            return "Estamos a una décima de 2."
        case 2:
            return "Ahora estamos diez veces más cerca."
        default:
            return "Estamos cien veces más cerca que al inicio."
        }
    }
}

private struct ApproachValueCard: View {
    let direction: String
    let arrow: String
    let xValue: String
    let result: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Text(direction)
                .font(.system(size: 9, weight: .bold, design: .rounded))
                .tracking(1.4)
                .foregroundStyle(color)

            HStack(spacing: 6) {
                Text("x = \(xValue)")
                Text(arrow)
                    .foregroundStyle(color)
                Text("f(x) = \(result)")
            }
            .font(.system(size: 13, weight: .bold, design: .monospaced))
            .foregroundStyle(AppTheme.warmWhite)
            .minimumScaleFactor(0.7)
            .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 13)
        .background(color.opacity(0.085))
        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 13, style: .continuous)
                .stroke(color.opacity(0.28), lineWidth: 1)
        }
    }
}
