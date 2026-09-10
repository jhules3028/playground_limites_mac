import SwiftUI

struct EvaluationHeader: View {
    let currentIndex: Int
    let questions: [EvaluationQuestion]
    let answers: [String: String]
    let showsResults: Bool
    let onExit: () -> Void
    let onSelectQuestion: (Int) -> Void

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
                Text("EVALUACIÓN FINAL")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .tracking(2)
                    .foregroundStyle(AppTheme.softGold)

                Text(showsResults ? "Resultados y retroalimentación" : "Comprueba lo que aprendiste")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
            }

            Spacer()

            if !showsResults {
                HStack(spacing: 6) {
                    ForEach(questions.indices, id: \.self) { index in
                        Button {
                            onSelectQuestion(index)
                        } label: {
                            Text("\(index + 1)")
                                .font(.system(size: 10, weight: .bold, design: .rounded))
                                .foregroundStyle(numberColor(for: index))
                                .frame(width: 27, height: 27)
                                .background(numberBackground(for: index))
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(index == currentIndex ? AppTheme.softGold : Color.white.opacity(0.1), lineWidth: index == currentIndex ? 2 : 1)
                                }
                        }
                        .buttonStyle(.plain)
                        .help(answers[questions[index].id] == nil ? "Pregunta sin responder" : "Pregunta respondida")
                    }
                }

                Text("\(answers.count) / \(questions.count) respondidas")
                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppTheme.mutedText)
                    .frame(width: 112, alignment: .trailing)
            }
        }
        .padding(.horizontal, 48)
        .padding(.top, 30)
        .padding(.bottom, 14)
    }

    private func numberBackground(for index: Int) -> Color {
        if index == currentIndex {
            return AppTheme.gold.opacity(0.2)
        }
        if answers[questions[index].id] != nil {
            return AppTheme.lightBlue.opacity(0.2)
        }
        return Color.white.opacity(0.055)
    }

    private func numberColor(for index: Int) -> Color {
        if index == currentIndex { return AppTheme.softGold }
        if answers[questions[index].id] != nil { return AppTheme.lightBlue }
        return AppTheme.mutedText
    }
}

struct EvaluationOptionButton: View {
    let displayLetter: String
    let option: EvaluationOption
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 14) {
                Text(displayLetter)
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundStyle(isSelected ? AppTheme.deepNavy : AppTheme.softGold)
                    .frame(width: 30, height: 30)
                    .background(isSelected ? AppTheme.gold : AppTheme.gold.opacity(0.1))
                    .clipShape(Circle())

                Text(option.text)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer(minLength: 8)

                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(isSelected ? AppTheme.softGold : Color.white.opacity(0.22))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, minHeight: 56, alignment: .leading)
            .background(isSelected ? AppTheme.gold.opacity(0.14) : Color.white.opacity(0.045))
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(isSelected ? AppTheme.gold.opacity(0.8) : Color.white.opacity(0.09), lineWidth: isSelected ? 1.5 : 1)
            }
        }
        .buttonStyle(.plain)
    }
}

struct EvaluationQuestionResource: View {
    let visual: EvaluationVisual

    var body: some View {
        ModuleCard {
            VStack(alignment: .leading, spacing: 11) {
                HStack {
                    LessonEyebrow(text: visual == .numericalTable ? "Tabla de valores" : "Recurso gráfico")
                    Spacer()
                    Text(visual == .numericalTable ? "x → 2" : "f(x) = x + 2")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .foregroundStyle(AppTheme.lightBlue)
                }

                switch visual {
                case .numericalTable:
                    EvaluationNumericalTable()
                case .graphUndefined:
                    ModuleThreeGraph(xValue: 2, targetCase: .undefined, showsMovingPoint: false)
                case .graphDifferent:
                    ModuleThreeGraph(xValue: 2, targetCase: .different, showsMovingPoint: false)
                case .graphContinuous:
                    ModuleThreeGraph(xValue: 2, targetCase: .continuous, showsMovingPoint: false)
                }
            }
        }
    }
}

private struct EvaluationNumericalTable: View {
    private let rows = [
        ("1.9", "3.9", "2.1", "4.1"),
        ("1.99", "3.99", "2.01", "4.01"),
        ("1.999", "3.999", "2.001", "4.001")
    ]

    var body: some View {
        VStack(spacing: 7) {
            Text("f(x) = (x² − 4)/(x − 2)")
                .font(.system(size: 15, weight: .bold, design: .serif))
                .foregroundStyle(AppTheme.warmWhite)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 3)

            tableRow(["x < 2", "f(x)", "x > 2", "f(x)"], isHeader: true)

            ForEach(rows.indices, id: \.self) { index in
                tableRow([rows[index].0, rows[index].1, rows[index].2, rows[index].3], isHeader: false)
            }

            HStack(spacing: 7) {
                Image(systemName: "arrow.right")
                Text("3.999  →  4  ←  4.001")
            }
            .font(.system(size: 12, weight: .bold, design: .monospaced))
            .foregroundStyle(AppTheme.softGold)
            .frame(maxWidth: .infinity)
            .padding(.top, 4)
        }
    }

    private func tableRow(_ values: [String], isHeader: Bool) -> some View {
        HStack(spacing: 6) {
            ForEach(values.indices, id: \.self) { index in
                Text(values[index])
                    .font(.system(size: isHeader ? 10 : 12.5, weight: isHeader ? .bold : .semibold, design: .monospaced))
                    .foregroundStyle(isHeader ? AppTheme.softGold : AppTheme.warmWhite)
                    .frame(maxWidth: .infinity)
                    .frame(height: isHeader ? 28 : 34)
                    .background(isHeader ? AppTheme.gold.opacity(0.1) : Color.white.opacity(0.045))
                    .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
            }
        }
    }
}
