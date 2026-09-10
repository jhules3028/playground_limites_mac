import SwiftUI

struct ModuleThreeGraph: View {
    let xValue: Double
    let targetCase: FunctionAtTargetCase
    var showsMovingPoint = true

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let limitPoint = graphPoint(x: ModuleThreeExample.targetX, y: ModuleThreeExample.limitValue, in: size)
            let currentValue = ModuleThreeExample.functionValue(at: xValue, targetCase: targetCase)

            ZStack {
                grid(in: size)
                    .stroke(Color.white.opacity(0.055), lineWidth: 1)

                axes(in: size)
                    .stroke(Color.white.opacity(0.35), style: StrokeStyle(lineWidth: 1.2, lineCap: .round))

                limitGuides(in: size)
                    .stroke(AppTheme.gold.opacity(0.52), style: StrokeStyle(lineWidth: 1.1, dash: [5, 5]))

                functionPath(in: size)
                    .stroke(AppTheme.lightBlue, style: StrokeStyle(lineWidth: 3.2, lineCap: .round, lineJoin: .round))

                if showsMovingPoint, let currentValue, abs(xValue - ModuleThreeExample.targetX) >= 0.005 {
                    movingGuide(x: xValue, y: currentValue, in: size)
                        .stroke(AppTheme.success.opacity(0.35), style: StrokeStyle(lineWidth: 1, dash: [3, 4]))

                    Circle()
                        .fill(AppTheme.success)
                        .frame(width: 13, height: 13)
                        .shadow(color: AppTheme.success.opacity(0.75), radius: 8)
                        .position(graphPoint(x: xValue, y: currentValue, in: size))
                }

                limitMarker(at: limitPoint)

                if targetCase == .continuous {
                    Circle()
                        .fill(AppTheme.success)
                        .frame(width: 9, height: 9)
                        .position(limitPoint)
                }

                if targetCase == .different {
                    let differentPoint = graphPoint(
                        x: ModuleThreeExample.targetX,
                        y: ModuleThreeExample.differentFunctionValue,
                        in: size
                    )

                    Circle()
                        .fill(AppTheme.error)
                        .frame(width: 14, height: 14)
                        .shadow(color: AppTheme.error.opacity(0.6), radius: 7)
                        .position(differentPoint)

                    Text("f(a)")
                        .font(.system(size: 10, weight: .bold, design: .serif))
                        .foregroundStyle(AppTheme.error)
                        .position(x: differentPoint.x + 27, y: differentPoint.y - 10)
                }

                graphLabels(in: size, limitPoint: limitPoint)
            }
        }
        .padding(8)
        .background(Color.black.opacity(0.14))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .accessibilityLabel("Interactive Cartesian graph with a target point, limit value, and function value")
    }

    @ViewBuilder
    private func limitMarker(at point: CGPoint) -> some View {
        Circle()
            .fill(AppTheme.navy)
            .frame(width: 18, height: 18)
            .overlay(Circle().stroke(AppTheme.softGold, lineWidth: 3))
            .position(point)
    }

    @ViewBuilder
    private func graphLabels(in size: CGSize, limitPoint: CGPoint) -> some View {
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
            .foregroundStyle(AppTheme.softGold)
            .position(x: limitPoint.x + 25, y: xAxisY(in: size) + 14)

        Text("L = 4")
            .font(.system(size: 9.5, weight: .bold, design: .monospaced))
            .foregroundStyle(AppTheme.softGold)
            .position(x: yAxisX(in: size) + 27, y: limitPoint.y - 13)
    }

    private func graphPoint(x: Double, y: Double, in size: CGSize) -> CGPoint {
        let xMin = -1.0
        let xMax = 5.0
        let yMin = -1.0
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
            for value in -1...5 {
                let x = graphPoint(x: Double(value), y: 0, in: size).x
                path.move(to: CGPoint(x: x, y: 0))
                path.addLine(to: CGPoint(x: x, y: size.height))
            }

            for value in -1...7 {
                let y = graphPoint(x: 0, y: Double(value), in: size).y
                path.move(to: CGPoint(x: 0, y: y))
                path.addLine(to: CGPoint(x: size.width, y: y))
            }
        }
    }

    private func axes(in size: CGSize) -> Path {
        Path { path in
            let axisY = xAxisY(in: size)
            let axisX = yAxisX(in: size)
            path.move(to: CGPoint(x: 0, y: axisY))
            path.addLine(to: CGPoint(x: size.width, y: axisY))
            path.move(to: CGPoint(x: axisX, y: size.height))
            path.addLine(to: CGPoint(x: axisX, y: 0))
        }
    }

    private func limitGuides(in size: CGSize) -> Path {
        let target = graphPoint(x: ModuleThreeExample.targetX, y: ModuleThreeExample.limitValue, in: size)

        return Path { path in
            path.move(to: CGPoint(x: target.x, y: xAxisY(in: size)))
            path.addLine(to: target)
            path.addLine(to: CGPoint(x: yAxisX(in: size), y: target.y))
        }
    }

    private func movingGuide(x: Double, y: Double, in size: CGSize) -> Path {
        let current = graphPoint(x: x, y: y, in: size)

        return Path { path in
            path.move(to: CGPoint(x: current.x, y: xAxisY(in: size)))
            path.addLine(to: current)
        }
    }

    private func functionPath(in size: CGSize) -> Path {
        Path { path in
            if targetCase == .continuous {
                let start = graphPoint(x: ModuleThreeExample.minimumX, y: ModuleThreeExample.nearbyValue(at: ModuleThreeExample.minimumX), in: size)
                let end = graphPoint(x: ModuleThreeExample.maximumX, y: ModuleThreeExample.nearbyValue(at: ModuleThreeExample.maximumX), in: size)
                path.move(to: start)
                path.addLine(to: end)
            } else {
                let leftStart = graphPoint(x: ModuleThreeExample.minimumX, y: ModuleThreeExample.nearbyValue(at: ModuleThreeExample.minimumX), in: size)
                let leftEnd = graphPoint(x: 1.94, y: ModuleThreeExample.nearbyValue(at: 1.94), in: size)
                let rightStart = graphPoint(x: 2.06, y: ModuleThreeExample.nearbyValue(at: 2.06), in: size)
                let rightEnd = graphPoint(x: ModuleThreeExample.maximumX, y: ModuleThreeExample.nearbyValue(at: ModuleThreeExample.maximumX), in: size)
                path.move(to: leftStart)
                path.addLine(to: leftEnd)
                path.move(to: rightStart)
                path.addLine(to: rightEnd)
            }
        }
    }
}
