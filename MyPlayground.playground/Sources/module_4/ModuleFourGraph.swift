import SwiftUI

struct ModuleFourGraph: View {
    let comparison: LateralComparisonCase
    var focusedSide: LateralSide?
    var xValue: Double?

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size

            ZStack {
                grid(in: size)
                    .stroke(Color.white.opacity(0.055), lineWidth: 1)

                axes(in: size)
                    .stroke(Color.white.opacity(0.38), style: StrokeStyle(lineWidth: 1.2, lineCap: .round))

                targetGuide(in: size)
                    .stroke(Color.white.opacity(0.2), style: StrokeStyle(lineWidth: 1, dash: [4, 5]))

                lateralLimitGuides(in: size)

                branch(for: .left, in: size)
                    .stroke(
                        AppTheme.lightBlue.opacity(branchOpacity(for: .left)),
                        style: StrokeStyle(lineWidth: 3.2, lineCap: .round, lineJoin: .round)
                    )

                branch(for: .right, in: size)
                    .stroke(
                        AppTheme.softGold.opacity(branchOpacity(for: .right)),
                        style: StrokeStyle(lineWidth: 3.2, lineCap: .round, lineJoin: .round)
                    )

                limitMarkers(in: size)
                movingPoint(in: size)
                labels(in: size)
            }
        }
        .padding(8)
        .background(Color.black.opacity(0.14))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .accessibilityLabel("Gráfica de los límites laterales alrededor de a igual a 2")
    }

    private func graphPoint(x: Double, y: Double, in size: CGSize) -> CGPoint {
        let xMin = -0.2
        let xMax = 4.2
        let yMin = 0.0
        let yMax = 7.0
        let mappedX = (x - xMin) / (xMax - xMin) * size.width
        let mappedY = size.height - ((y - yMin) / (yMax - yMin) * size.height)
        return CGPoint(x: mappedX, y: mappedY)
    }

    private func xAxisY(in size: CGSize) -> CGFloat {
        graphPoint(x: 0, y: 0, in: size).y
    }

    private func yAxisX(in size: CGSize) -> CGFloat {
        graphPoint(x: 0, y: 0, in: size).x
    }

    private func grid(in size: CGSize) -> Path {
        Path { path in
            for value in 0...4 {
                let x = graphPoint(x: Double(value), y: 0, in: size).x
                path.move(to: CGPoint(x: x, y: 0))
                path.addLine(to: CGPoint(x: x, y: size.height))
            }

            for value in 0...7 {
                let y = graphPoint(x: 0, y: Double(value), in: size).y
                path.move(to: CGPoint(x: 0, y: y))
                path.addLine(to: CGPoint(x: size.width, y: y))
            }
        }
    }

    private func axes(in size: CGSize) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: xAxisY(in: size)))
            path.addLine(to: CGPoint(x: size.width, y: xAxisY(in: size)))
            path.move(to: CGPoint(x: yAxisX(in: size), y: size.height))
            path.addLine(to: CGPoint(x: yAxisX(in: size), y: 0))
        }
    }

    private func targetGuide(in size: CGSize) -> Path {
        let targetX = graphPoint(x: ModuleFourExample.targetX, y: 0, in: size).x
        return Path { path in
            path.move(to: CGPoint(x: targetX, y: 0))
            path.addLine(to: CGPoint(x: targetX, y: size.height))
        }
    }

    @ViewBuilder
    private func lateralLimitGuides(in size: CGSize) -> some View {
        let leftLimit = ModuleFourExample.lateralLimit(for: .left, comparison: comparison)
        let rightLimit = ModuleFourExample.lateralLimit(for: .right, comparison: comparison)

        limitGuide(side: .left, value: leftLimit, in: size)
            .stroke(AppTheme.lightBlue.opacity(0.38), style: StrokeStyle(lineWidth: 1, dash: [4, 5]))

        if rightLimit != leftLimit {
            limitGuide(side: .right, value: rightLimit, in: size)
                .stroke(AppTheme.softGold.opacity(0.38), style: StrokeStyle(lineWidth: 1, dash: [4, 5]))
        }
    }

    private func limitGuide(side: LateralSide, value: Double, in size: CGSize) -> Path {
        let target = graphPoint(x: ModuleFourExample.targetX, y: value, in: size)
        let axis = yAxisX(in: size)

        return Path { path in
            switch side {
            case .left:
                path.move(to: CGPoint(x: axis, y: target.y))
                path.addLine(to: target)
            case .right:
                path.move(to: target)
                path.addLine(to: CGPoint(x: size.width, y: target.y))
            }
        }
    }

    private func branch(for side: LateralSide, in size: CGSize) -> Path {
        let startX: Double
        let endX: Double

        switch side {
        case .left:
            startX = 0.05
            endX = 1.965
        case .right:
            startX = 2.035
            endX = 3.95
        }

        let start = graphPoint(
            x: startX,
            y: ModuleFourExample.value(at: startX, side: side, comparison: comparison),
            in: size
        )
        let end = graphPoint(
            x: endX,
            y: ModuleFourExample.value(at: endX, side: side, comparison: comparison),
            in: size
        )

        return Path { path in
            path.move(to: start)
            path.addLine(to: end)
        }
    }

    private func branchOpacity(for side: LateralSide) -> Double {
        guard let focusedSide else { return 1 }
        return focusedSide == side ? 1 : 0.2
    }

    @ViewBuilder
    private func limitMarkers(in size: CGSize) -> some View {
        let leftValue = ModuleFourExample.lateralLimit(for: .left, comparison: comparison)
        let rightValue = ModuleFourExample.lateralLimit(for: .right, comparison: comparison)
        let leftPoint = graphPoint(x: ModuleFourExample.targetX, y: leftValue, in: size)
        let rightPoint = graphPoint(x: ModuleFourExample.targetX, y: rightValue, in: size)

        HollowLateralMarker(color: AppTheme.lightBlue)
            .opacity(branchOpacity(for: .left))
            .position(leftPoint)

        if rightValue != leftValue {
            HollowLateralMarker(color: AppTheme.softGold)
                .opacity(branchOpacity(for: .right))
                .position(rightPoint)
        } else {
            Circle()
                .trim(from: 0.5, to: 1)
                .stroke(AppTheme.softGold, lineWidth: 3)
                .frame(width: 18, height: 18)
                .rotationEffect(.degrees(90))
                .position(rightPoint)
        }
    }

    @ViewBuilder
    private func movingPoint(in size: CGSize) -> some View {
        if let focusedSide, let xValue {
            let yValue = ModuleFourExample.value(at: xValue, side: focusedSide, comparison: comparison)
            let point = graphPoint(x: xValue, y: yValue, in: size)
            let color = focusedSide == .left ? AppTheme.lightBlue : AppTheme.softGold

            Path { path in
                path.move(to: CGPoint(x: point.x, y: xAxisY(in: size)))
                path.addLine(to: point)
            }
            .stroke(color.opacity(0.35), style: StrokeStyle(lineWidth: 1, dash: [3, 4]))

            Circle()
                .fill(color)
                .frame(width: 14, height: 14)
                .shadow(color: color.opacity(0.7), radius: 8)
                .position(point)
        }
    }

    @ViewBuilder
    private func labels(in size: CGSize) -> some View {
        let targetX = graphPoint(x: ModuleFourExample.targetX, y: 0, in: size).x
        let leftLimit = ModuleFourExample.lateralLimit(for: .left, comparison: comparison)
        let rightLimit = ModuleFourExample.lateralLimit(for: .right, comparison: comparison)

        Text("x")
            .font(.system(size: 11, weight: .bold, design: .serif))
            .foregroundStyle(AppTheme.warmWhite)
            .position(x: size.width - 8, y: xAxisY(in: size) - 13)

        Text("y")
            .font(.system(size: 11, weight: .bold, design: .serif))
            .foregroundStyle(AppTheme.warmWhite)
            .position(x: yAxisX(in: size) + 12, y: 9)

        Text("a = 2")
            .font(.system(size: 9.5, weight: .bold, design: .monospaced))
            .foregroundStyle(AppTheme.warmWhite)
            .position(x: targetX + 27, y: size.height - 13)

        Text("L⁻ = \(Int(leftLimit))")
            .font(.system(size: 9.5, weight: .bold, design: .monospaced))
            .foregroundStyle(AppTheme.lightBlue)
            .position(x: yAxisX(in: size) + 32, y: graphPoint(x: 0, y: leftLimit, in: size).y - 12)

        Text("L⁺ = \(Int(rightLimit))")
            .font(.system(size: 9.5, weight: .bold, design: .monospaced))
            .foregroundStyle(AppTheme.softGold)
            .position(x: size.width - 35, y: graphPoint(x: 0, y: rightLimit, in: size).y - 12)
    }
}

private struct HollowLateralMarker: View {
    let color: Color

    var body: some View {
        Circle()
            .fill(AppTheme.navy)
            .frame(width: 18, height: 18)
            .overlay(Circle().stroke(color, lineWidth: 3))
    }
}
