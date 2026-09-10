import SwiftUI

struct ModuleSixGraph: View {
    let continuityCase: ContinuityCase
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

                limitGuides(in: size)
                functionPaths(in: size)
                targetMarkers(in: size)
                movingMarker(in: size)
                graphLabels(in: size)
            }
        }
        .padding(8)
        .background(Color.black.opacity(0.14))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .accessibilityLabel("Graph of the selected continuity case around x equal to 2")
    }

    private func graphPoint(x: Double, y: Double, in size: CGSize) -> CGPoint {
        let xMin = -0.2
        let xMax = 4.2
        let yMin = continuityCase == .removable ? -0.6 : 0.0
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
        let x = graphPoint(x: ModuleSixExample.targetX, y: 0, in: size).x
        return Path { path in
            path.move(to: CGPoint(x: x, y: 0))
            path.addLine(to: CGPoint(x: x, y: size.height))
        }
    }

    @ViewBuilder
    private func limitGuides(in size: CGSize) -> some View {
        let leftLimit = ModuleSixExample.leftLimit(for: continuityCase)
        let rightLimit = ModuleSixExample.rightLimit(for: continuityCase)

        if continuityCase == .jump {
            horizontalGuide(value: leftLimit, side: .left, in: size)
                .stroke(AppTheme.lightBlue.opacity(0.38), style: StrokeStyle(lineWidth: 1, dash: [4, 5]))
            horizontalGuide(value: rightLimit, side: .right, in: size)
                .stroke(AppTheme.softGold.opacity(0.38), style: StrokeStyle(lineWidth: 1, dash: [4, 5]))
        } else {
            horizontalGuide(value: leftLimit, side: nil, in: size)
                .stroke(AppTheme.softGold.opacity(0.38), style: StrokeStyle(lineWidth: 1, dash: [4, 5]))
        }
    }

    private func horizontalGuide(value: Double, side: ContinuityGraphSide?, in size: CGSize) -> Path {
        let y = graphPoint(x: 0, y: value, in: size).y
        let targetX = graphPoint(x: ModuleSixExample.targetX, y: 0, in: size).x

        return Path { path in
            if side == .left {
                path.move(to: CGPoint(x: yAxisX(in: size), y: y))
                path.addLine(to: CGPoint(x: targetX, y: y))
            } else if side == .right {
                path.move(to: CGPoint(x: targetX, y: y))
                path.addLine(to: CGPoint(x: size.width, y: y))
            } else {
                path.move(to: CGPoint(x: yAxisX(in: size), y: y))
                path.addLine(to: CGPoint(x: size.width, y: y))
            }
        }
    }

    @ViewBuilder
    private func functionPaths(in size: CGSize) -> some View {
        switch continuityCase {
        case .continuous:
            linePath(startX: 0.05, endX: 3.95, continuityCase: continuityCase, in: size)
                .stroke(AppTheme.lightBlue, style: StrokeStyle(lineWidth: 3.2, lineCap: .round))

        case .removable:
            linePath(startX: 0.05, endX: 1.965, continuityCase: continuityCase, in: size)
                .stroke(AppTheme.lightBlue, style: StrokeStyle(lineWidth: 3.2, lineCap: .round))
            linePath(startX: 2.035, endX: 3.95, continuityCase: continuityCase, in: size)
                .stroke(AppTheme.lightBlue, style: StrokeStyle(lineWidth: 3.2, lineCap: .round))

        case .jump:
            linePath(startX: 0.05, endX: 1.965, continuityCase: continuityCase, in: size)
                .stroke(AppTheme.lightBlue, style: StrokeStyle(lineWidth: 3.2, lineCap: .round))
            linePath(startX: 2.035, endX: 3.9, continuityCase: continuityCase, in: size)
                .stroke(AppTheme.softGold, style: StrokeStyle(lineWidth: 3.2, lineCap: .round))
        }
    }

    private func linePath(startX: Double, endX: Double, continuityCase: ContinuityCase, in size: CGSize) -> Path {
        let side: ContinuityGraphSide = endX < ModuleSixExample.targetX ? .left : .right
        let startY = nearbyValue(at: startX, side: side, continuityCase: continuityCase)
        let endY = nearbyValue(at: endX, side: side, continuityCase: continuityCase)

        return Path { path in
            path.move(to: graphPoint(x: startX, y: startY, in: size))
            path.addLine(to: graphPoint(x: endX, y: endY, in: size))
        }
    }

    private func nearbyValue(at x: Double, side: ContinuityGraphSide, continuityCase: ContinuityCase) -> Double {
        switch continuityCase {
        case .continuous, .removable:
            return x + 2
        case .jump:
            return side == .left ? x + 1 : x + 3
        }
    }

    @ViewBuilder
    private func targetMarkers(in size: CGSize) -> some View {
        switch continuityCase {
        case .continuous:
            let point = graphPoint(x: 2, y: 4, in: size)
            Circle()
                .fill(AppTheme.success)
                .frame(width: 15, height: 15)
                .shadow(color: AppTheme.success.opacity(0.6), radius: 7)
                .position(point)

        case .removable:
            HollowContinuityMarker(color: AppTheme.softGold)
                .position(graphPoint(x: 2, y: 4, in: size))

            Circle()
                .fill(AppTheme.error)
                .frame(width: 15, height: 15)
                .shadow(color: AppTheme.error.opacity(0.55), radius: 7)
                .position(graphPoint(x: 2, y: 0, in: size))

        case .jump:
            HollowContinuityMarker(color: AppTheme.lightBlue)
                .position(graphPoint(x: 2, y: 3, in: size))

            Circle()
                .fill(AppTheme.softGold)
                .frame(width: 15, height: 15)
                .shadow(color: AppTheme.softGold.opacity(0.55), radius: 7)
                .position(graphPoint(x: 2, y: 5, in: size))
        }
    }

    @ViewBuilder
    private func movingMarker(in size: CGSize) -> some View {
        if let xValue,
           abs(xValue - ModuleSixExample.targetX) >= 0.005,
           let yValue = ModuleSixExample.value(at: xValue, continuityCase: continuityCase) {
            let point = graphPoint(x: xValue, y: yValue, in: size)
            let color = continuityCase == .jump && xValue > ModuleSixExample.targetX ? AppTheme.softGold : AppTheme.success

            Path { path in
                path.move(to: CGPoint(x: point.x, y: xAxisY(in: size)))
                path.addLine(to: point)
            }
            .stroke(color.opacity(0.35), style: StrokeStyle(lineWidth: 1, dash: [3, 4]))

            Circle()
                .fill(color)
                .frame(width: 13, height: 13)
                .shadow(color: color.opacity(0.65), radius: 7)
                .position(point)
        }
    }

    @ViewBuilder
    private func graphLabels(in size: CGSize) -> some View {
        let targetX = graphPoint(x: 2, y: 0, in: size).x

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

        if continuityCase == .jump {
            Text("L⁻ = 3")
                .font(.system(size: 9.5, weight: .bold, design: .monospaced))
                .foregroundStyle(AppTheme.lightBlue)
                .position(x: yAxisX(in: size) + 31, y: graphPoint(x: 0, y: 3, in: size).y - 12)
            Text("L⁺ = 5")
                .font(.system(size: 9.5, weight: .bold, design: .monospaced))
                .foregroundStyle(AppTheme.softGold)
                .position(x: size.width - 34, y: graphPoint(x: 0, y: 5, in: size).y - 12)
        } else {
            Text("L = 4")
                .font(.system(size: 9.5, weight: .bold, design: .monospaced))
                .foregroundStyle(AppTheme.softGold)
                .position(x: yAxisX(in: size) + 29, y: graphPoint(x: 0, y: 4, in: size).y - 12)
        }
    }
}

private struct HollowContinuityMarker: View {
    let color: Color

    var body: some View {
        Circle()
            .fill(AppTheme.navy)
            .frame(width: 18, height: 18)
            .overlay(Circle().stroke(color, lineWidth: 3))
    }
}

private enum ContinuityGraphSide {
    case left
    case right
}
