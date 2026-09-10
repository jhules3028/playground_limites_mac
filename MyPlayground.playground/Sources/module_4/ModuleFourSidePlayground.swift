import SwiftUI

struct ModuleFourSidePlayground: View {
    let side: LateralSide
    @State private var proximity = 0.22

    private var xValue: Double {
        ModuleFourExample.xValue(for: proximity, side: side)
    }

    private var functionValue: Double {
        ModuleFourExample.value(at: xValue, side: side)
    }

    private var lateralLimit: Double {
        ModuleFourExample.lateralLimit(for: side)
    }

    private var color: Color {
        side == .left ? AppTheme.lightBlue : AppTheme.softGold
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 890 {
                        HStack(alignment: .top, spacing: 26) {
                            explanationPanel
                                .frame(width: 305)
                            playgroundPanel
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            explanationPanel
                            playgroundPanel
                        }
                    }
                }
                .frame(maxWidth: 1_040)
                .padding(.horizontal, 48)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var explanationPanel: some View {
        VStack(alignment: .leading, spacing: 15) {
            LessonEyebrow(text: side == .left ? "Pantalla 2 · Experimentar" : "Pantalla 3 · Experimentar")

            Text(side == .left ? "Acércate por la izquierda" : "Acércate por la derecha")
                .font(.system(size: 29, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text(sideExplanation)
                .font(.system(size: 13.5, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            ModuleCard {
                VStack(alignment: .leading, spacing: 9) {
                    Text(side == .left ? "REGLA PARA x < 2" : "REGLA PARA x > 2")
                        .font(.system(size: 9.5, weight: .bold, design: .rounded))
                        .tracking(1.2)
                        .foregroundStyle(color)

                    Text(side == .left ? "f(x) = x + 1" : "f(x) = x + 3")
                        .font(.system(size: 23, weight: .semibold, design: .serif))
                        .foregroundStyle(AppTheme.warmWhite)

                    Text(side == .left ? "limₓ→₂⁻ f(x) = 3" : "limₓ→₂⁺ f(x) = 5")
                        .font(.system(size: 18, weight: .bold, design: .serif))
                        .foregroundStyle(color)
                }
            }

            HStack(spacing: 9) {
                LateralMetricCard(label: "x", value: ModuleFourExample.format(xValue), color: color)
                LateralMetricCard(label: "f(x)", value: ModuleFourExample.format(functionValue), color: AppTheme.success)
            }

            HStack(alignment: .top, spacing: 10) {
                Image(systemName: "nosign")
                    .foregroundStyle(AppTheme.softGold)
                Text("El control nunca permite x = 2. En su punto máximo sólo llega a \(closestXText).")
                    .font(.system(size: 11.5, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(12)
            .background(AppTheme.gold.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }

    private var playgroundPanel: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    LessonEyebrow(text: "Playground lateral")
                    Text("Nivel de acercamiento")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                }

                Spacer()

                Text("\(Int(proximity * 100))%")
                    .font(.system(size: 20, weight: .bold, design: .monospaced))
                    .foregroundStyle(color)
            }

            ModuleFourGraph(comparison: .jump, focusedSide: side, xValue: xValue)
                .frame(height: 295)

            VStack(spacing: 8) {
                Slider(value: $proximity, in: 0...1)
                    .tint(color)

                HStack {
                    Text("LEJOS")
                    Spacer()
                    Text("MÁS CERCA, SIN LLEGAR A 2  →")
                }
                .font(.system(size: 9.5, weight: .bold, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)

                HStack(spacing: 8) {
                    ProximityPreset(title: "Inicio", detail: "lejos") { setProximity(0) }
                    ProximityPreset(title: "Acercar", detail: "bastante") { setProximity(0.72) }
                    ProximityPreset(title: "Máximo", detail: closestXText) { setProximity(1) }
                }
            }

            Text(observation)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)
                .lineSpacing(2)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 13)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(color.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }

    private var sideExplanation: String {
        switch side {
        case .left:
            return "Usaremos únicamente valores menores que 2. Al aumentar el acercamiento, x avanza hacia 2 y f(x) se aproxima a 3."
        case .right:
            return "Usaremos únicamente valores mayores que 2. Al aumentar el acercamiento, x retrocede hacia 2 y f(x) se aproxima a 5."
        }
    }

    private var closestXText: String {
        side == .left ? "x = 1.999" : "x = 2.001"
    }

    private var observation: String {
        let distance = ModuleFourExample.distanceDescription(for: proximity)
        return "Estás a \(distance) unidades de a = 2. f(x) = \(ModuleFourExample.format(functionValue)) se acerca al límite lateral \(Int(lateralLimit))."
    }

    private func setProximity(_ value: Double) {
        withAnimation(.easeInOut(duration: 0.3)) {
            proximity = value
        }
    }
}

private struct ProximityPreset: View {
    let title: String
    let detail: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 2) {
                Text(title)
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                Text(detail)
                    .font(.system(size: 10.5, weight: .semibold, design: .monospaced))
            }
            .foregroundStyle(AppTheme.warmWhite)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 7)
            .background(Color.white.opacity(0.065))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}
