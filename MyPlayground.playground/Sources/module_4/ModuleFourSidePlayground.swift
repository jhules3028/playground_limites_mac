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
            LessonEyebrow(text: side == .left ? "Screen 2 · Explore" : "Screen 3 · Explore")

            Text(side == .left ? "Approach from the Left" : "Approach from the Right")
                .font(.system(size: 29, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text(sideExplanation)
                .font(.system(size: 13.5, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            ModuleCard {
                VStack(alignment: .leading, spacing: 9) {
                    Text(side == .left ? "RULE FOR x < 2" : "RULE FOR x > 2")
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
                Text("The control never allows x = 2. At its maximum, it only reaches \(closestXText).")
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
                    LessonEyebrow(text: "One-Sided Playground")
                    Text("Approach Level")
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
                    Text("FAR")
                    Spacer()
                    Text("CLOSER, WITHOUT REACHING 2  →")
                }
                .font(.system(size: 9.5, weight: .bold, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)

                HStack(spacing: 8) {
                    ProximityPreset(title: "Start", detail: "far") { setProximity(0) }
                    ProximityPreset(title: "Closer", detail: "near") { setProximity(0.72) }
                    ProximityPreset(title: "Maximum", detail: closestXText) { setProximity(1) }
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
            return "We will use only values less than 2. As you move closer, x advances toward 2 and f(x) approaches 3."
        case .right:
            return "We will use only values greater than 2. As you move closer, x moves back toward 2 and f(x) approaches 5."
        }
    }

    private var closestXText: String {
        side == .left ? "x = 1.999" : "x = 2.001"
    }

    private var observation: String {
        let distance = ModuleFourExample.distanceDescription(for: proximity)
        return "You are \(distance) units from a = 2. f(x) = \(ModuleFourExample.format(functionValue)) is approaching the one-sided limit \(Int(lateralLimit))."
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
