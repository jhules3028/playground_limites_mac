import SwiftUI

struct ModuleFourHeader: View {
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
                Text("MÓDULO 4")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .tracking(2)
                    .foregroundStyle(AppTheme.softGold)

                Text("Límites laterales")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
            }

            Spacer()

            HStack(spacing: 7) {
                ForEach(0..<pageCount, id: \.self) { page in
                    Capsule()
                        .fill(page <= currentPage ? AppTheme.gold : Color.white.opacity(0.13))
                        .frame(width: page == currentPage ? 30 : 10, height: 7)
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
        .padding(.bottom, 16)
    }
}

struct ModuleFourNavigation: View {
    let currentPage: Int
    let pageCount: Int
    let onPrevious: () -> Void
    let onNext: () -> Void

    var body: some View {
        HStack {
            Button(action: onPrevious) {
                Label(currentPage == 0 ? "Módulo 3" : "Anterior", systemImage: "arrow.left")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .padding(.horizontal, 18)
                    .frame(height: 42)
                    .background(Color.white.opacity(0.075))
                    .clipShape(Capsule())
            }
            .buttonStyle(.plain)

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
        .padding(.top, 14)
        .padding(.bottom, 30)
    }

}

struct LateralDefinitionCard: View {
    let side: LateralSide
    let expression: String
    let description: String

    private var color: Color {
        side == .left ? AppTheme.lightBlue : AppTheme.softGold
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Label(
                    side == .left ? "POR LA IZQUIERDA" : "POR LA DERECHA",
                    systemImage: side == .left ? "arrow.right" : "arrow.left"
                )
                .font(.system(size: 9.5, weight: .bold, design: .rounded))
                .tracking(1.2)
                .foregroundStyle(color)

                Spacer()
            }

            Text(expression)
                .font(.system(size: 20, weight: .semibold, design: .serif))
                .foregroundStyle(AppTheme.warmWhite)

            Text(description)
                .font(.system(size: 11.5, weight: .medium, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(color.opacity(0.085))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .stroke(color.opacity(0.25), lineWidth: 1)
        }
    }
}

struct LateralMetricCard: View {
    let label: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.system(size: 9.5, weight: .semibold, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
            Text(value)
                .font(.system(size: 17, weight: .bold, design: .monospaced))
                .foregroundStyle(color)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(Color.black.opacity(0.14))
        .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
    }
}

struct LateralComparisonSelector: View {
    @Binding var selection: LateralComparisonCase

    var body: some View {
        HStack(spacing: 8) {
            ForEach(LateralComparisonCase.allCases) { comparison in
                Button {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        selection = comparison
                    }
                } label: {
                    Label(
                        comparison.title,
                        systemImage: comparison == .matching ? "equal.circle.fill" : "arrow.up.and.down.circle.fill"
                    )
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundStyle(selection == comparison ? AppTheme.deepNavy : AppTheme.warmWhite)
                    .frame(maxWidth: .infinity)
                    .frame(height: 42)
                    .background(selection == comparison ? AppTheme.gold : Color.white.opacity(0.06))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                .buttonStyle(.plain)
            }
        }
    }
}
