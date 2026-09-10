import SwiftUI

struct ModuleFiveHeader: View {
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
                Text("MÓDULO 5")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .tracking(2)
                    .foregroundStyle(AppTheme.softGold)

                Text("Cálculo algebraico")
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

struct ModuleFiveNavigation: View {
    let currentPage: Int
    let pageCount: Int
    let onPrevious: () -> Void
    let onNext: () -> Void

    var body: some View {
        HStack {
            Button(action: onPrevious) {
                Label(currentPage == 0 ? "Módulo 4" : "Anterior", systemImage: "arrow.left")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .padding(.horizontal, 18)
                    .frame(height: 42)
                    .background(Color.white.opacity(0.075))
                    .clipShape(Capsule())
            }
            .buttonStyle(.plain)

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
        .padding(.top, 14)
        .padding(.bottom, 30)
    }

    private var pageTitle: String {
        switch currentPage {
        case 0:
            return "SUSTITUCIÓN DIRECTA"
        case 1:
            return "FORMA 0/0"
        case 2:
            return "FACTORIZACIÓN"
        case 3:
            return "RACIONALIZACIÓN"
        default:
            return "EVALUACIÓN"
        }
    }
}

struct AlgebraFormulaCard: View {
    let eyebrow: String
    let expression: String
    let explanation: String
    var color = AppTheme.softGold

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(eyebrow.uppercased())
                .font(.system(size: 9.5, weight: .bold, design: .rounded))
                .tracking(1.2)
                .foregroundStyle(color)

            Text(expression)
                .font(.system(size: 22, weight: .semibold, design: .serif))
                .foregroundStyle(AppTheme.warmWhite)
                .minimumScaleFactor(0.68)
                .lineLimit(1)

            Text(explanation)
                .font(.system(size: 11.5, weight: .medium, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(2)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(color.opacity(0.085))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .stroke(color.opacity(0.24), lineWidth: 1)
        }
    }
}

struct AlgebraStepRow: View {
    let number: Int
    let title: String
    let expression: String
    let explanation: String
    var color = AppTheme.lightBlue

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text("\(number)")
                .font(.system(size: 11, weight: .black, design: .rounded))
                .foregroundStyle(AppTheme.deepNavy)
                .frame(width: 28, height: 28)
                .background(color)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 11.5, weight: .bold, design: .rounded))
                    .foregroundStyle(color)

                Text(expression)
                    .font(.system(size: 17, weight: .semibold, design: .serif))
                    .foregroundStyle(AppTheme.warmWhite)
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)

                Text(explanation)
                    .font(.system(size: 10.5, weight: .medium, design: .rounded))
                    .foregroundStyle(AppTheme.mutedText)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)
        }
    }
}

struct AlgebraChoiceOption: View {
    let label: String
    let text: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 11) {
                Text(label)
                    .font(.system(size: 10.5, weight: .bold, design: .rounded))
                    .foregroundStyle(isSelected ? AppTheme.deepNavy : AppTheme.softGold)
                    .frame(width: 28, height: 28)
                    .background(isSelected ? AppTheme.gold : AppTheme.gold.opacity(0.1))
                    .clipShape(Circle())

                Text(text)
                    .font(.system(size: 11.5, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
            .padding(10)
            .background(Color.white.opacity(isSelected ? 0.1 : 0.045))
            .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 11, style: .continuous)
                    .stroke(isSelected ? AppTheme.gold.opacity(0.7) : Color.white.opacity(0.07), lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
    }
}

struct AlgebraFeedback: View {
    let isCorrect: Bool
    let correctText: String
    let incorrectText: String

    var body: some View {
        HStack(alignment: .top, spacing: 9) {
            Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundStyle(isCorrect ? AppTheme.success : AppTheme.error)

            Text(isCorrect ? correctText : incorrectText)
                .font(.system(size: 10.8, weight: .medium, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(10)
        .background((isCorrect ? AppTheme.success : AppTheme.error).opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}
