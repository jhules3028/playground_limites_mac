import SwiftUI

struct ModuleTwoHeader: View {
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
            .help("Back to cover")

            VStack(alignment: .leading, spacing: 3) {
                Text("MODULE 2")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .tracking(2)
                    .foregroundStyle(AppTheme.softGold)

                Text("Limits Using Tables")
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

struct ModuleTwoNavigation: View {
    let currentPage: Int
    let pageCount: Int
    let onPrevious: () -> Void
    let onNext: () -> Void

    var body: some View {
        HStack {
            Button(action: onPrevious) {
                Label(currentPage == 0 ? "Module 1" : "Previous", systemImage: "arrow.left")
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
                    Text(currentPage == pageCount - 1 ? "Finish Module" : "Next")
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

}

struct NumericalLimitTable: View {
    let highlightedPrecision: Int?

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                TableHeaderCell(title: "x < 2", color: AppTheme.lightBlue)
                TableHeaderCell(title: "f(x)", color: AppTheme.lightBlue)
                TableHeaderCell(title: "precision", color: AppTheme.softGold)
                TableHeaderCell(title: "x > 2", color: AppTheme.softGold)
                TableHeaderCell(title: "f(x)", color: AppTheme.softGold)
            }
            .padding(.vertical, 11)
            .background(Color.black.opacity(0.18))

            ForEach(ModuleTwoExample.rows) { row in
                HStack(spacing: 0) {
                    TableValueCell(text: ModuleTwoExample.format(row.leftX, precision: row.precision), color: AppTheme.lightBlue)
                    TableValueCell(text: ModuleTwoExample.format(row.leftResult, precision: row.precision), color: AppTheme.warmWhite)
                    TableValueCell(text: "10⁻\(row.precision)", color: AppTheme.softGold)
                    TableValueCell(text: ModuleTwoExample.format(row.rightX, precision: row.precision), color: AppTheme.softGold)
                    TableValueCell(text: ModuleTwoExample.format(row.rightResult, precision: row.precision), color: AppTheme.warmWhite)
                }
                .padding(.vertical, 13)
                .background(
                    row.precision == highlightedPrecision
                        ? AppTheme.gold.opacity(0.13)
                        : Color.white.opacity(row.precision.isMultiple(of: 2) ? 0.035 : 0.015)
                )
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        }
    }
}

private struct TableHeaderCell: View {
    let title: String
    let color: Color

    var body: some View {
        Text(title)
            .font(.system(size: 10, weight: .bold, design: .rounded))
            .tracking(0.7)
            .foregroundStyle(color)
            .frame(maxWidth: .infinity)
    }
}

private struct TableValueCell: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(.system(size: 13, weight: .semibold, design: .monospaced))
            .foregroundStyle(color)
            .frame(maxWidth: .infinity)
    }
}

struct PrecisionSelector: View {
    @Binding var precision: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(ModuleTwoExample.supportedPrecisions, id: \.self) { value in
                Button {
                    withAnimation(.easeInOut(duration: 0.24)) {
                        precision = value
                    }
                } label: {
                    VStack(spacing: 3) {
                        Text("\(value)")
                            .font(.system(size: 18, weight: .bold, design: .monospaced))
                        Text(value == 1 ? "decimal place" : "decimal places")
                            .font(.system(size: 9, weight: .semibold, design: .rounded))
                    }
                    .foregroundStyle(precision == value ? AppTheme.deepNavy : AppTheme.warmWhite)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(precision == value ? AppTheme.gold : Color.white.opacity(0.06))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                .buttonStyle(.plain)
            }
        }
    }
}
