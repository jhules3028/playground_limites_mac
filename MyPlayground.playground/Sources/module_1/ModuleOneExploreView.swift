import SwiftUI

struct ModuleOneExploreView: View {
    @State private var xValue = 0.50

    private var functionValue: Double? {
        ModuleOneExample.functionValue(at: xValue)
    }

    private var distanceToTarget: Double {
        ModuleOneExample.distanceToTarget(from: xValue)
    }

    private var accentColor: Color {
        xValue < ModuleOneExample.targetX ? AppTheme.lightBlue : AppTheme.softGold
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 880 {
                        HStack(alignment: .top, spacing: 26) {
                            explanationPanel
                                .frame(width: 320)

                            experimentPanel
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            explanationPanel
                            experimentPanel
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
        VStack(alignment: .leading, spacing: 18) {
            LessonEyebrow(text: "Pantalla 2 · Experimentar")

            Text("Acerca x al objetivo")
                .font(.system(size: 31, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text("En este ejemplo, la gráfica sigue la regla f(x) = x + 2, pero dejamos un hueco cuando x = 2.")
                .font(.system(size: 14, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 10) {
                TargetBadge(symbol: "a", value: "2", caption: "objetivo")
                TargetBadge(symbol: "L", value: "4", caption: "límite")
            }

            ModuleCard {
                VStack(alignment: .leading, spacing: 9) {
                    Label("Tu misión", systemImage: "scope")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.softGold)

                    Text("Mueve el deslizador y observa qué sucede con f(x) cuando x se acerca cada vez más a 2.")
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            HStack(spacing: 8) {
                PresetButton(title: "Lejos", value: 0.50, selection: $xValue)
                PresetButton(title: "Cerca", value: 1.80, selection: $xValue)
                PresetButton(title: "Muy cerca", value: 1.99, selection: $xValue)
            }
        }
    }

    private var experimentPanel: some View {
        ModuleCard {
            VStack(spacing: 16) {
                LimitExperimentGraph(xValue: xValue)
                    .frame(height: 245)

                VStack(spacing: 8) {
                    Slider(
                        value: $xValue,
                        in: ModuleOneExample.minimumX...ModuleOneExample.maximumX,
                        step: 0.01
                    )
                    .tint(accentColor)

                    HStack {
                        Text("0.2")
                        Spacer()
                        Text("a = 2")
                            .foregroundStyle(AppTheme.softGold)
                        Spacer()
                        Text("3.8")
                    }
                    .font(.system(size: 10, weight: .semibold, design: .monospaced))
                    .foregroundStyle(AppTheme.mutedText)
                }

                HStack(spacing: 10) {
                    ExperimentValueCard(label: "x", value: ModuleOneExample.formatted(xValue), color: accentColor)
                    ExperimentValueCard(label: "f(x)", value: functionValueText, color: accentColor)
                    ExperimentValueCard(label: "distancia a", value: ModuleOneExample.formatted(distanceToTarget), color: AppTheme.warmWhite)
                }

                HStack(alignment: .top, spacing: 11) {
                    Image(systemName: messageIcon)
                        .foregroundStyle(messageColor)
                        .font(.system(size: 16, weight: .bold))

                    Text(feedbackMessage)
                        .font(.system(size: 12.5, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(13)
                .background(messageColor.opacity(0.11))
                .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
            }
        }
    }

    private var functionValueText: String {
        guard let functionValue else {
            return "no definida"
        }

        return ModuleOneExample.formatted(functionValue)
    }

    private var feedbackMessage: String {
        if functionValue == nil {
            return "En x = 2 hay un hueco: f(2) no está definida. Aun así, los valores cercanos muestran que el límite es 4."
        }

        if distanceToTarget < 0.03 {
            return "¡Muy cerca! x se aproxima a 2 y, al mismo tiempo, f(x) se aproxima a 4."
        }

        if distanceToTarget < 0.30 {
            return "Vas acercándote: al disminuir la distancia entre x y 2, también disminuye la distancia entre f(x) y 4."
        }

        return "Todavía estás lejos del objetivo. Arrastra x hacia 2 y observa cómo responde la función."
    }

    private var messageIcon: String {
        distanceToTarget < 0.03 || functionValue == nil ? "checkmark.circle.fill" : "arrow.right.circle.fill"
    }

    private var messageColor: Color {
        distanceToTarget < 0.03 || functionValue == nil ? AppTheme.success : accentColor
    }
}

private struct TargetBadge: View {
    let symbol: String
    let value: String
    let caption: String

    var body: some View {
        VStack(spacing: 4) {
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(symbol)
                    .foregroundStyle(AppTheme.softGold)
                Text("=")
                    .foregroundStyle(AppTheme.mutedText)
                Text(value)
                    .foregroundStyle(AppTheme.warmWhite)
            }
            .font(.system(size: 21, weight: .bold, design: .serif))

            Text(caption.uppercased())
                .font(.system(size: 8, weight: .bold, design: .rounded))
                .tracking(1.3)
                .foregroundStyle(AppTheme.mutedText)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.white.opacity(0.055))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}

private struct PresetButton: View {
    let title: String
    let value: Double
    @Binding var selection: Double

    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.28)) {
                selection = value
            }
        } label: {
            Text(title)
                .font(.system(size: 10.5, weight: .semibold, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 9)
                .background(Color.white.opacity(abs(selection - value) < 0.005 ? 0.14 : 0.06))
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

private struct ExperimentValueCard: View {
    let label: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 5) {
            Text(label)
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)

            Text(value)
                .font(.system(size: value.count > 7 ? 12 : 17, weight: .bold, design: .monospaced))
                .foregroundStyle(color)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(Color.black.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

private struct LimitExperimentGraph: View {
    let xValue: Double

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let targetPoint = point(x: ModuleOneExample.targetX, y: ModuleOneExample.limitValue, in: size)

            ZStack {
                grid(in: size)
                    .stroke(Color.white.opacity(0.06), lineWidth: 1)

                axes(in: size)
                    .stroke(Color.white.opacity(0.30), lineWidth: 1.2)

                targetGuide(in: size)
                    .stroke(AppTheme.gold.opacity(0.55), style: StrokeStyle(lineWidth: 1.2, dash: [5, 5]))

                functionSegment(from: 0.2, to: 1.96, in: size)
                    .stroke(AppTheme.lightBlue, style: StrokeStyle(lineWidth: 3, lineCap: .round))

                functionSegment(from: 2.04, to: 3.8, in: size)
                    .stroke(AppTheme.lightBlue, style: StrokeStyle(lineWidth: 3, lineCap: .round))

                Circle()
                    .fill(AppTheme.navy)
                    .frame(width: 17, height: 17)
                    .overlay(Circle().stroke(AppTheme.softGold, lineWidth: 3))
                    .position(targetPoint)

                if let yValue = ModuleOneExample.functionValue(at: xValue) {
                    Circle()
                        .fill(xValue < ModuleOneExample.targetX ? AppTheme.lightBlue : AppTheme.softGold)
                        .frame(width: 13, height: 13)
                        .shadow(color: accentColor.opacity(0.8), radius: 8)
                        .position(point(x: xValue, y: yValue, in: size))
                }

                Text("a = 2")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundStyle(AppTheme.softGold)
                    .position(x: targetPoint.x + 25, y: size.height - 12)

                Text("L = 4")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundStyle(AppTheme.softGold)
                    .position(x: 27, y: targetPoint.y - 12)
            }
        }
        .padding(8)
        .background(Color.black.opacity(0.13))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .accessibilityLabel("Gráfica interactiva de f de x igual a x más dos con un hueco en x igual a dos")
    }

    private var accentColor: Color {
        xValue < ModuleOneExample.targetX ? AppTheme.lightBlue : AppTheme.softGold
    }

    private func point(x: Double, y: Double, in size: CGSize) -> CGPoint {
        let xPosition = (x - 0.0) / 4.0 * size.width
        let yPosition = size.height - ((y - 2.0) / 4.0 * size.height)
        return CGPoint(x: xPosition, y: yPosition)
    }

    private func grid(in size: CGSize) -> Path {
        Path { path in
            for index in 1..<8 {
                let x = size.width * CGFloat(index) / 8
                path.move(to: CGPoint(x: x, y: 0))
                path.addLine(to: CGPoint(x: x, y: size.height))
            }

            for index in 1..<6 {
                let y = size.height * CGFloat(index) / 6
                path.move(to: CGPoint(x: 0, y: y))
                path.addLine(to: CGPoint(x: size.width, y: y))
            }
        }
    }

    private func axes(in size: CGSize) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: size.height))
            path.addLine(to: CGPoint(x: size.width, y: size.height))
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: size.height))
        }
    }

    private func targetGuide(in size: CGSize) -> Path {
        let target = point(x: ModuleOneExample.targetX, y: ModuleOneExample.limitValue, in: size)

        return Path { path in
            path.move(to: CGPoint(x: target.x, y: size.height))
            path.addLine(to: target)
            path.addLine(to: CGPoint(x: 0, y: target.y))
        }
    }

    private func functionSegment(from start: Double, to end: Double, in size: CGSize) -> Path {
        Path { path in
            path.move(to: point(x: start, y: start + 2, in: size))
            path.addLine(to: point(x: end, y: end + 2, in: size))
        }
    }
}
