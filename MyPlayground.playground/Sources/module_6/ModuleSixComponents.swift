import SwiftUI

struct ModuleSixHeader: View {
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
                Text("MÓDULO 6")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .tracking(2)
                    .foregroundStyle(AppTheme.softGold)

                Text("Continuidad")
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

struct ModuleSixNavigation: View {
    let currentPage: Int
    let pageCount: Int
    let onPrevious: () -> Void
    let onNext: () -> Void

    var body: some View {
        HStack {
            Button(action: onPrevious) {
                Label(currentPage == 0 ? "Módulo 5" : "Anterior", systemImage: "arrow.left")
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

struct ContinuityConditionList: View {
    let continuityCase: ContinuityCase

    private var results: [Bool] {
        ModuleSixExample.conditionResults(for: continuityCase)
    }

    var body: some View {
        VStack(spacing: 8) {
            ContinuityConditionRow(number: 1, text: "f(2) existe", detail: functionDetail, isSatisfied: results[0])
            ContinuityConditionRow(number: 2, text: "limₓ→₂ f(x) existe", detail: limitDetail, isSatisfied: results[1])
            ContinuityConditionRow(number: 3, text: "limₓ→₂ f(x) = f(2)", detail: equalityDetail, isSatisfied: results[2])
        }
    }

    private var functionDetail: String {
        guard let value = ModuleSixExample.functionAtTarget(for: continuityCase) else { return "No está definida" }
        return "f(2) = \(Int(value))"
    }

    private var limitDetail: String {
        guard let value = ModuleSixExample.bilateralLimit(for: continuityCase) else { return "Los laterales difieren" }
        return "L = \(Int(value))"
    }

    private var equalityDetail: String {
        results[2] ? "Los dos valores coinciden" : "La igualdad no se cumple"
    }
}

private struct ContinuityConditionRow: View {
    let number: Int
    let text: String
    let detail: String
    let isSatisfied: Bool

    var body: some View {
        HStack(spacing: 10) {
            Text("\(number)")
                .font(.system(size: 10, weight: .black, design: .rounded))
                .foregroundStyle(AppTheme.deepNavy)
                .frame(width: 25, height: 25)
                .background(isSatisfied ? AppTheme.success : AppTheme.error)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(text)
                    .font(.system(size: 11.5, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                Text(detail)
                    .font(.system(size: 9.8, weight: .medium, design: .rounded))
                    .foregroundStyle(AppTheme.mutedText)
            }

            Spacer()

            Image(systemName: isSatisfied ? "checkmark" : "xmark")
                .font(.system(size: 10, weight: .black))
                .foregroundStyle(isSatisfied ? AppTheme.success : AppTheme.error)
        }
        .padding(.horizontal, 11)
        .frame(height: 45)
        .background(Color.white.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
    }
}

struct ContinuityMetricCard: View {
    let label: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.system(size: 9.5, weight: .semibold, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
            Text(value)
                .font(.system(size: value.count > 9 ? 11 : 16, weight: .bold, design: .monospaced))
                .foregroundStyle(color)
                .lineLimit(1)
                .minimumScaleFactor(0.65)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 9)
        .background(Color.black.opacity(0.14))
        .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
    }
}
