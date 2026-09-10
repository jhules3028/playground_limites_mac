import SwiftUI

struct EvaluationQuestionView: View {
    let question: EvaluationQuestion
    let questionNumber: Int
    let totalQuestions: Int
    let selectedOptionID: String?
    let onSelectOption: (String) -> Void

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    HStack(alignment: .center) {
                        HStack(spacing: 9) {
                            Text("MÓDULO \(question.moduleNumber)")
                                .font(.system(size: 10, weight: .bold, design: .rounded))
                                .tracking(1.7)
                                .foregroundStyle(AppTheme.softGold)

                            Text(question.moduleTitle)
                                .font(.system(size: 11, weight: .semibold, design: .rounded))
                                .foregroundStyle(AppTheme.mutedText)
                        }

                        Spacer()

                        Text("Pregunta \(questionNumber) de \(totalQuestions)")
                            .font(.system(size: 11, weight: .bold, design: .monospaced))
                            .foregroundStyle(AppTheme.lightBlue)
                    }

                    if let visual = question.visual, geometry.size.width >= 900 {
                        HStack(alignment: .top, spacing: 24) {
                            EvaluationQuestionResource(visual: visual)
                                .frame(width: min(420, geometry.size.width * 0.41), height: 310)

                            questionCard
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 18) {
                            if let visual = question.visual {
                                EvaluationQuestionResource(visual: visual)
                                    .frame(height: 300)
                            }

                            questionCard
                        }
                    }

                }
                .frame(maxWidth: 1_080)
                .padding(.horizontal, 48)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var questionCard: some View {
        ModuleCard {
            VStack(alignment: .leading, spacing: 16) {
                Text(question.prompt)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .lineSpacing(3)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(spacing: 10) {
                    ForEach(Array(question.options.enumerated()), id: \.element.id) { index, option in
                        EvaluationOptionButton(
                            displayLetter: displayLetter(for: index),
                            option: option,
                            isSelected: selectedOptionID == option.id
                        ) {
                            onSelectOption(option.id)
                        }
                    }
                }
            }
        }
    }

    private func displayLetter(for index: Int) -> String {
        guard index >= 0 && index < 26 else { return "?" }
        return String(UnicodeScalar(65 + index)!)
    }
}
