import SwiftUI

struct ModuleFourExistenceView: View {
    @State private var comparison: LateralComparisonCase = .matching

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 890 {
                        HStack(alignment: .top, spacing: 26) {
                            rulePanel
                                .frame(width: 330)
                            comparisonPanel
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            rulePanel
                            comparisonPanel
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

    private var rulePanel: some View {
        VStack(alignment: .leading, spacing: 15) {
            LessonEyebrow(text: "Pantalla 4 · Comparar")

            Text("¿Cuándo existe el límite?")
                .font(.system(size: 29, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text("El límite bilateral existe solamente cuando las aproximaciones por izquierda y derecha llegan al mismo valor.")
                .font(.system(size: 13.5, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            ModuleCard {
                VStack(spacing: 11) {
                    Text("CONDICIÓN DE EXISTENCIA")
                        .font(.system(size: 9.5, weight: .bold, design: .rounded))
                        .tracking(1.3)
                        .foregroundStyle(AppTheme.softGold)

                    Text("limₓ→ₐ⁻ f(x) = limₓ→ₐ⁺ f(x)")
                        .font(.system(size: 20, weight: .semibold, design: .serif))
                        .foregroundStyle(AppTheme.warmWhite)
                        .minimumScaleFactor(0.72)
                        .lineLimit(1)

                    Rectangle()
                        .fill(Color.white.opacity(0.11))
                        .frame(height: 1)

                    Text("Si son diferentes, limₓ→ₐ f(x) no existe.")
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundStyle(AppTheme.mutedText)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity)
            }

            LateralComparisonSelector(selection: $comparison)

            conclusionCard
        }
    }

    private var comparisonPanel: some View {
        VStack(alignment: .leading, spacing: 13) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    LessonEyebrow(text: "Compara ambos casos")
                    Text(comparison == .matching ? "Los dos lados apuntan a 4" : "Aparece un salto entre 3 y 5")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                }
                Spacer()
            }

            ModuleFourGraph(comparison: comparison)
                .frame(height: 305)

            HStack(spacing: 10) {
                LateralMetricCard(
                    label: "límite izquierdo",
                    value: "L⁻ = \(Int(leftLimit))",
                    color: AppTheme.lightBlue
                )
                Image(systemName: comparison == .matching ? "equal" : "not.equal")
                    .font(.system(size: 19, weight: .bold))
                    .foregroundStyle(comparison == .matching ? AppTheme.success : AppTheme.error)
                LateralMetricCard(
                    label: "límite derecho",
                    value: "L⁺ = \(Int(rightLimit))",
                    color: AppTheme.softGold
                )
            }

            Text(comparisonExplanation)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)
                .lineSpacing(2)
                .fixedSize(horizontal: false, vertical: true)
                .padding(13)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background((comparison == .matching ? AppTheme.success : AppTheme.error).opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }

    private var conclusionCard: some View {
        HStack(spacing: 11) {
            Image(systemName: comparison == .matching ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(comparison == .matching ? AppTheme.success : AppTheme.error)

            VStack(alignment: .leading, spacing: 3) {
                Text(comparison == .matching ? "El límite existe" : "El límite no existe")
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)

                Text(comparison == .matching ? "limₓ→₂ f(x) = 4" : "limₓ→₂ f(x) = DNE")
                    .font(.system(size: 15, weight: .bold, design: .serif))
                    .foregroundStyle(comparison == .matching ? AppTheme.success : AppTheme.error)
            }
        }
        .padding(13)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.055))
        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
    }

    private var leftLimit: Double {
        ModuleFourExample.lateralLimit(for: .left, comparison: comparison)
    }

    private var rightLimit: Double {
        ModuleFourExample.lateralLimit(for: .right, comparison: comparison)
    }

    private var comparisonExplanation: String {
        switch comparison {
        case .matching:
            return "Como L⁻ = 4 y L⁺ = 4, las dos direcciones coinciden. El límite bilateral existe y vale 4."
        case .jump:
            return "Como L⁻ = 3 y L⁺ = 5, cada dirección apunta a un valor distinto. El límite bilateral no existe."
        }
    }
}
