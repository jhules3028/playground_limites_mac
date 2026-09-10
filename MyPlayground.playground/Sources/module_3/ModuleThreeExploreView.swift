import SwiftUI

struct ModuleThreeExploreView: View {
    @State private var targetCase: FunctionAtTargetCase = .undefined
    @State private var xValue = 1.25

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 900 {
                        HStack(alignment: .top, spacing: 26) {
                            controlsPanel
                                .frame(width: 285)
                            interactivePanel
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            controlsPanel
                            interactivePanel
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

    private var controlsPanel: some View {
        VStack(alignment: .leading, spacing: 15) {
            LessonEyebrow(text: "Pantalla 2 · Explorar")

            Text("Cambia el valor en el punto")
                .font(.system(size: 28, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text("Elige qué ocurre exactamente en a = 2. La curva cercana permanece igual para que compares el límite con f(a).")
                .font(.system(size: 13, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)

            TargetCaseSelector(selection: $targetCase)

            ModuleCard {
                VStack(alignment: .leading, spacing: 7) {
                    Text(targetCase.title)
                        .font(.system(size: 16, weight: .bold, design: .serif))
                        .foregroundStyle(caseColor)

                    Text(targetCase.explanation)
                        .font(.system(size: 11.5, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                        .lineSpacing(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }

    private var interactivePanel: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    LessonEyebrow(text: "Gráfica interactiva")
                    Text("Mueve x hacia a = 2")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                }

                Spacer()
                GraphLegend()
            }

            ModuleThreeGraph(xValue: xValue, targetCase: targetCase)
                .frame(height: 240)

            HStack(spacing: 10) {
                GraphMetricCard(label: "x", value: ModuleThreeExample.format(xValue), color: AppTheme.lightBlue)
                GraphMetricCard(label: "f(x)", value: displayedFunctionValue, color: currentFunctionColor)
                GraphMetricCard(label: "límite L", value: "4.00", color: AppTheme.softGold)
                GraphMetricCard(label: "f(a)", value: targetFunctionValue, color: caseColor)
            }

            VStack(spacing: 7) {
                Slider(value: $xValue, in: ModuleThreeExample.minimumX...ModuleThreeExample.maximumX, step: 0.01)
                    .tint(AppTheme.lightBlue)

                HStack {
                    PresetButton(title: "Izquierda", value: "1.90") { setX(1.9) }
                    PresetButton(title: "En a", value: "2.00") { setX(2.0) }
                    PresetButton(title: "Derecha", value: "2.10") { setX(2.1) }
                }
            }

            Text(dynamicObservation)
                .font(.system(size: 11.5, weight: .semibold, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)
                .lineSpacing(2)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 13)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(caseColor.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }

    private var displayedFunctionValue: String {
        guard let value = ModuleThreeExample.functionValue(at: xValue, targetCase: targetCase) else {
            return "no definida"
        }
        return ModuleThreeExample.format(value)
    }

    private var targetFunctionValue: String {
        switch targetCase {
        case .continuous:
            return "4.00"
        case .undefined:
            return "no existe"
        case .different:
            return "6.00"
        }
    }

    private var currentFunctionColor: Color {
        abs(xValue - ModuleThreeExample.targetX) < 0.005 ? caseColor : AppTheme.success
    }

    private var caseColor: Color {
        switch targetCase {
        case .continuous:
            return AppTheme.success
        case .undefined:
            return AppTheme.softGold
        case .different:
            return AppTheme.error
        }
    }

    private var dynamicObservation: String {
        if abs(xValue - ModuleThreeExample.targetX) < 0.005 {
            switch targetCase {
            case .continuous:
                return "En x = 2, la función vale 4. Aquí f(a) coincide con el límite."
            case .undefined:
                return "En x = 2 aparece un hueco: f(a) no existe, aunque el límite sigue siendo 4."
            case .different:
                return "En x = 2, el punto rojo fija f(a) = 6; la curva cercana continúa apuntando a L = 4."
            }
        }

        let side = xValue < ModuleThreeExample.targetX ? "izquierda" : "derecha"
        return "Te acercas por la \(side): f(x) = \(ModuleThreeExample.format(ModuleThreeExample.nearbyValue(at: xValue))). Al aproximarte a 2, este valor se acerca a 4."
    }

    private func setX(_ newValue: Double) {
        withAnimation(.easeInOut(duration: 0.28)) {
            xValue = newValue
        }
    }
}

private struct PresetButton: View {
    let title: String
    let value: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 2) {
                Text(title)
                    .font(.system(size: 9.5, weight: .semibold, design: .rounded))
                Text(value)
                    .font(.system(size: 11, weight: .bold, design: .monospaced))
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
