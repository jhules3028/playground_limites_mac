import AppKit
import SwiftUI

struct CoverView: View {
    let onStart: () -> Void

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    institutionalHeader
                        .padding(.bottom, 24)

                    if geometry.size.width >= 900 {
                        HStack(spacing: 52) {
                            heroContent
                                .frame(maxWidth: 500, alignment: .leading)

                            LimitPreviewCard()
                                .frame(maxWidth: 430)
                        }
                    } else {
                        VStack(spacing: 34) {
                            heroContent
                                .frame(maxWidth: 650, alignment: .leading)

                            LimitPreviewCard()
                                .frame(maxWidth: 520)
                        }
                    }

                    footer
                        .padding(.top, 26)
                }
                .frame(maxWidth: 1_080)
                .padding(.horizontal, 50)
                .padding(.vertical, 34)
                .frame(minHeight: geometry.size.height)
            }
            .background(decorativeBackground)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(AppTheme.gold.opacity(0.58), lineWidth: 1.5)
                    .padding(18)
                    .allowsHitTesting(false)
            }
        }
    }

    private var institutionalHeader: some View {
        HStack(spacing: 18) {
            FESLogoView()
                .frame(width: 250, height: 60, alignment: .leading)

            Rectangle()
                .fill(AppTheme.gold.opacity(0.7))
                .frame(width: 1, height: 38)

            VStack(alignment: .leading, spacing: 4) {
                Text("UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .tracking(1.25)
                    .foregroundStyle(AppTheme.mutedText)

                Text("Learning object · Calculus I")
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
            }

            Spacer()

            Text("01—07")
                .font(.system(size: 12, weight: .semibold, design: .monospaced))
                .foregroundStyle(AppTheme.softGold)
                .padding(.horizontal, 13)
                .padding(.vertical, 8)
                .overlay {
                    Capsule()
                        .stroke(AppTheme.gold.opacity(0.55), lineWidth: 1)
                }
        }
    }

    private var heroContent: some View {
        VStack(alignment: .leading, spacing: 22) {
            Text("CALCULUS I  /  LIMITS")
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .tracking(2.5)
                .foregroundStyle(AppTheme.softGold)

            Text("Explore the limits")
                .font(.system(size: 56, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("Discover how a function behaves as it approaches a point through visual, numerical, and algebraic experiences.")
                .font(.system(size: 17, weight: .regular, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(5)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 10) {
                FeaturePill(icon: "eye.fill", title: "Observe")
                FeaturePill(icon: "lightbulb.fill", title: "Understand")
                FeaturePill(icon: "checkmark.circle.fill", title: "Practice")
            }

            Button(action: onStart) {
                HStack(spacing: 18) {
                    Text("Start")
                        .font(.system(size: 16, weight: .bold, design: .rounded))

                    Image(systemName: "arrow.right")
                        .font(.system(size: 15, weight: .bold))
                }
                .foregroundStyle(AppTheme.deepNavy)
                .padding(.leading, 24)
                .padding(.trailing, 18)
                .frame(height: 50)
                .background(
                    LinearGradient(
                        colors: [AppTheme.softGold, AppTheme.gold],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(Capsule())
                .shadow(color: AppTheme.gold.opacity(0.25), radius: 18, y: 8)
            }
            .buttonStyle(.plain)
            .accessibilityHint("Opens the first module about the intuitive idea of a limit")
        }
    }

    private var footer: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 3) {
                Text("CREATED BY")
                    .font(.system(size: 9, weight: .bold, design: .rounded))
                    .tracking(1.8)
                    .foregroundStyle(AppTheme.softGold.opacity(0.9))

                Text("Julián de Jesús Campos Brandt")
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite.opacity(0.9))
            }

            Spacer()

            Text("FES ACATLÁN · UNAM")
                .font(.system(size: 10, weight: .semibold, design: .rounded))
                .tracking(1.4)
                .foregroundStyle(AppTheme.mutedText)
        }
    }

    private var decorativeBackground: some View {
        ZStack {
            AppTheme.background

            Circle()
                .fill(AppTheme.blue.opacity(0.33))
                .frame(width: 480, height: 480)
                .blur(radius: 4)
                .offset(x: 420, y: -300)

            Circle()
                .fill(AppTheme.gold.opacity(0.07))
                .frame(width: 360, height: 360)
                .offset(x: -470, y: 320)

            Text("lim")
                .font(.system(size: 210, weight: .black, design: .serif))
                .foregroundStyle(Color.white.opacity(0.018))
                .rotationEffect(.degrees(-8))
                .offset(x: 390, y: 280)
        }
        .ignoresSafeArea()
    }
}

private struct FESLogoView: View {
    private var logo: NSImage? {
        guard let url = Bundle.main.url(
            forResource: "fes-acatlan-logo",
            withExtension: "png"
        ) else {
            return nil
        }

        return NSImage(contentsOf: url)
    }

    var body: some View {
        Group {
            if let logo {
                Image(nsImage: logo)
                    .resizable()
                    .scaledToFit()
                    .accessibilityLabel("Faculty of Higher Studies Acatlán")
            } else {
                VStack(alignment: .leading, spacing: 1) {
                    Text("FES")
                        .font(.system(size: 25, weight: .black, design: .rounded))
                    Text("ACATLÁN · UNAM")
                        .font(.system(size: 11, weight: .bold, design: .rounded))
                        .tracking(1.6)
                }
                .foregroundStyle(.white)
            }
        }
    }
}

private struct FeaturePill: View {
    let icon: String
    let title: String

    var body: some View {
        Label(title, systemImage: icon)
            .font(.system(size: 12, weight: .semibold, design: .rounded))
            .foregroundStyle(AppTheme.warmWhite.opacity(0.9))
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.white.opacity(0.07))
            .clipShape(Capsule())
            .overlay {
                Capsule()
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            }
    }
}

private struct LimitPreviewCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("A CORE IDEA")
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .tracking(1.8)
                        .foregroundStyle(AppTheme.softGold)

                    Text("Approaching without necessarily reaching")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                }

                Spacer()

                Image(systemName: "function")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(AppTheme.softGold)
                    .frame(width: 42, height: 42)
                    .background(AppTheme.gold.opacity(0.12))
                    .clipShape(Circle())
            }

            LimitCurvePreview()
                .frame(height: 205)

            HStack(spacing: 0) {
                ValueSummary(label: "x", value: "→ 2")
                Divider()
                    .overlay(Color.white.opacity(0.14))
                    .frame(height: 38)
                ValueSummary(label: "f(x)", value: "→ 4")
                Divider()
                    .overlay(Color.white.opacity(0.14))
                    .frame(height: 38)
                ValueSummary(label: "limit", value: "4")
            }

            Text("lim  (x² − 4) / (x − 2)  =  4")
                .font(.system(size: 18, weight: .semibold, design: .monospaced))
                .foregroundStyle(AppTheme.warmWhite)
                .frame(maxWidth: .infinity)

            Text("x → 2")
                .font(.system(size: 10, weight: .bold, design: .monospaced))
                .foregroundStyle(AppTheme.softGold)
                .offset(x: 51, y: -15)
        }
        .padding(24)
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color.white.opacity(0.15), lineWidth: 1)
        }
        .shadow(color: Color.black.opacity(0.25), radius: 30, y: 18)
    }
}

private struct ValueSummary: View {
    let label: String
    let value: String

    var body: some View {
        VStack(spacing: 3) {
            Text(label)
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
            Text(value)
                .font(.system(size: 15, weight: .bold, design: .monospaced))
                .foregroundStyle(AppTheme.warmWhite)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct LimitCurvePreview: View {
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let originX = size.width * 0.48
            let originY = size.height * 0.62
            let hole = CGPoint(x: size.width * 0.61, y: size.height * 0.36)

            ZStack {
                Path { path in
                    for index in 1..<6 {
                        let x = size.width * CGFloat(index) / 6
                        path.move(to: CGPoint(x: x, y: 0))
                        path.addLine(to: CGPoint(x: x, y: size.height))
                    }
                    for index in 1..<5 {
                        let y = size.height * CGFloat(index) / 5
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: size.width, y: y))
                    }
                }
                .stroke(Color.white.opacity(0.055), lineWidth: 1)

                Path { path in
                    path.move(to: CGPoint(x: 0, y: originY))
                    path.addLine(to: CGPoint(x: size.width, y: originY))
                    path.move(to: CGPoint(x: originX, y: size.height))
                    path.addLine(to: CGPoint(x: originX, y: 0))
                }
                .stroke(Color.white.opacity(0.28), lineWidth: 1)

                Path { path in
                    path.move(to: CGPoint(x: size.width * 0.08, y: size.height * 0.86))
                    path.addCurve(
                        to: CGPoint(x: hole.x - 8, y: hole.y + 5),
                        control1: CGPoint(x: size.width * 0.26, y: size.height * 0.82),
                        control2: CGPoint(x: size.width * 0.45, y: size.height * 0.52)
                    )
                }
                .stroke(AppTheme.lightBlue, style: StrokeStyle(lineWidth: 3, lineCap: .round))

                Path { path in
                    path.move(to: CGPoint(x: hole.x + 8, y: hole.y - 5))
                    path.addCurve(
                        to: CGPoint(x: size.width * 0.92, y: size.height * 0.10),
                        control1: CGPoint(x: size.width * 0.72, y: size.height * 0.22),
                        control2: CGPoint(x: size.width * 0.84, y: size.height * 0.13)
                    )
                }
                .stroke(AppTheme.lightBlue, style: StrokeStyle(lineWidth: 3, lineCap: .round))

                Circle()
                    .fill(AppTheme.navy)
                    .frame(width: 15, height: 15)
                    .overlay(Circle().stroke(AppTheme.softGold, lineWidth: 3))
                    .position(hole)

                Circle()
                    .fill(AppTheme.softGold)
                    .frame(width: 9, height: 9)
                    .shadow(color: AppTheme.gold.opacity(0.7), radius: 7)
                    .position(x: size.width * 0.35, y: size.height * 0.69)

                Text("L")
                    .font(.system(size: 11, weight: .bold, design: .monospaced))
                    .foregroundStyle(AppTheme.softGold)
                    .position(x: hole.x + 21, y: hole.y - 14)
            }
        }
        .padding(4)
        .background(Color.black.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .accessibilityLabel("Graph of a function approaching a hole")
    }
}
