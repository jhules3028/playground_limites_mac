import SwiftUI

struct ModuleOneHeader: View {
    let currentPage: Int
    let pageCount: Int
    let onExit: () -> Void

    var body: some View {
        HStack(spacing: 18) {
            Button(action: onExit) {
                Image(systemName: "house.fill")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(AppTheme.warmWhite)
                    .frame(width: 38, height: 38)
                    .background(Color.white.opacity(0.08))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white.opacity(0.12), lineWidth: 1))
            }
            .buttonStyle(.plain)
            .help("Volver a la portada")

            VStack(alignment: .leading, spacing: 3) {
                Text("MÓDULO 1")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .tracking(2)
                    .foregroundStyle(AppTheme.softGold)

                Text("Idea intuitiva del límite")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
            }

            Spacer()

            HStack(spacing: 8) {
                ForEach(0..<pageCount, id: \.self) { page in
                    Capsule()
                        .fill(page <= currentPage ? AppTheme.gold : Color.white.opacity(0.13))
                        .frame(width: page == currentPage ? 34 : 12, height: 7)
                        .animation(.easeInOut(duration: 0.25), value: currentPage)
                }
            }

            Text("\(currentPage + 1) / \(pageCount)")
                .font(.system(size: 12, weight: .semibold, design: .monospaced))
                .foregroundStyle(AppTheme.mutedText)
                .frame(width: 42, alignment: .trailing)
        }
        .padding(.horizontal, 48)
        .padding(.top, 32)
        .padding(.bottom, 18)
    }
}

struct ModuleOneNavigation: View {
    let currentPage: Int
    let pageCount: Int
    let onPrevious: () -> Void
    let onNext: () -> Void

    var body: some View {
        HStack {
            Button(action: onPrevious) {
                Label("Anterior", systemImage: "arrow.left")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundStyle(currentPage == 0 ? Color.white.opacity(0.25) : AppTheme.warmWhite)
                    .padding(.horizontal, 18)
                    .frame(height: 42)
                    .background(Color.white.opacity(currentPage == 0 ? 0.025 : 0.075))
                    .clipShape(Capsule())
            }
            .buttonStyle(.plain)
            .disabled(currentPage == 0)

            Spacer()

            Text(pageTitle)
                .font(.system(size: 11, weight: .medium, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)

            Spacer()

            Button(action: onNext) {
                HStack(spacing: 12) {
                    Text(currentPage == pageCount - 1 ? "Terminar módulo" : "Siguiente")
                    Image(systemName: currentPage == pageCount - 1 ? "checkmark" : "arrow.right")
                }
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(AppTheme.deepNavy)
                .padding(.horizontal, 20)
                .frame(height: 42)
                .background(
                    LinearGradient(
                        colors: [AppTheme.softGold, AppTheme.gold],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(Capsule())
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 48)
        .padding(.top, 16)
        .padding(.bottom, 32)
    }

    private var pageTitle: String {
        switch currentPage {
        case 0:
            return "CONCEPTO"
        case 1:
            return "EXPLORACIÓN"
        default:
            return "IDEA CLAVE"
        }
    }
}

struct ModuleCard<Content: View>: View {
    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(22)
            .background(AppTheme.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(Color.white.opacity(0.12), lineWidth: 1)
            }
    }
}

struct LessonEyebrow: View {
    let text: String

    var body: some View {
        Text(text.uppercased())
            .font(.system(size: 10, weight: .bold, design: .rounded))
            .tracking(2.2)
            .foregroundStyle(AppTheme.softGold)
    }
}

struct ConceptTile: View {
    let symbol: String
    let title: String
    let explanation: String

    var body: some View {
        HStack(alignment: .top, spacing: 13) {
            Text(symbol)
                .font(.system(size: 20, weight: .bold, design: .serif))
                .foregroundStyle(AppTheme.deepNavy)
                .frame(width: 40, height: 40)
                .background(AppTheme.gold)
                .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)

                Text(explanation)
                    .font(.system(size: 11.5, weight: .regular, design: .rounded))
                    .foregroundStyle(AppTheme.mutedText)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(Color.white.opacity(0.055))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}

struct ApproachAnalogyView: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let lineY = geometry.size.height * 0.58

            ZStack(alignment: .topLeading) {
                Path { path in
                    path.move(to: CGPoint(x: 28, y: lineY))
                    path.addLine(to: CGPoint(x: width - 50, y: lineY))
                }
                .stroke(Color.white.opacity(0.22), style: StrokeStyle(lineWidth: 2, dash: [7, 7]))

                ForEach(Array(analogyPoints.enumerated()), id: \.offset) { index, point in
                    VStack(spacing: 7) {
                        Circle()
                            .fill(index == analogyPoints.count - 1 ? AppTheme.softGold : AppTheme.lightBlue)
                            .frame(width: index == analogyPoints.count - 1 ? 13 : 9, height: index == analogyPoints.count - 1 ? 13 : 9)
                            .shadow(color: AppTheme.gold.opacity(index == analogyPoints.count - 1 ? 0.6 : 0), radius: 7)

                        Text(point.label)
                            .font(.system(size: 10, weight: .semibold, design: .monospaced))
                            .foregroundStyle(AppTheme.warmWhite.opacity(0.8))
                    }
                    .position(x: width * point.position, y: lineY + 19)
                }

                VStack(spacing: 5) {
                    Image(systemName: "door.left.hand.closed")
                        .font(.system(size: 30, weight: .medium))
                        .foregroundStyle(AppTheme.softGold)
                    Text("meta")
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.softGold)
                }
                .position(x: width - 27, y: lineY - 8)
            }
        }
    }

    private let analogyPoints: [(position: CGFloat, label: String)] = [
        (0.10, "1 m"),
        (0.38, "½ m"),
        (0.59, "¼ m"),
        (0.74, "⅛ m")
    ]
}
