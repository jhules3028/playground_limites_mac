import SwiftUI

struct EvaluationResultsView: View {
    let questions: [EvaluationQuestion]
    let answers: [String: String]
    let onRetry: () -> Void
    let onExit: () -> Void
    let onStudyModule: (Int) -> Void

    private var correctCount: Int {
        questions.filter { answers[$0.id] == $0.correctOptionID }.count
    }

    private var incorrectCount: Int {
        questions.count - correctCount
    }

    private var percentage: Int {
        guard !questions.isEmpty else { return 0 }
        return Int((Double(correctCount) / Double(questions.count) * 100).rounded())
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 22) {
                resultSummary

                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading, spacing: 5) {
                            LessonEyebrow(text: "Revisión del intento")
                            Text("Aprende de cada respuesta")
                                .font(.system(size: 25, weight: .heavy, design: .rounded))
                                .foregroundStyle(AppTheme.warmWhite)
                        }

                        Spacer()

                        Text("Las opciones ya aparecen calificadas")
                            .font(.system(size: 10.5, weight: .medium, design: .rounded))
                            .foregroundStyle(AppTheme.mutedText)
                    }

                    ForEach(Array(questions.enumerated()), id: \.element.id) { index, question in
                        EvaluationReviewCard(
                            number: index + 1,
                            question: question,
                            selectedOptionID: answers[question.id],
                            onStudyModule: { onStudyModule(question.moduleNumber) }
                        )
                    }
                }
            }
            .frame(maxWidth: 1_020)
            .padding(.horizontal, 48)
            .padding(.top, 8)
            .padding(.bottom, 40)
            .frame(maxWidth: .infinity)
        }
    }

    private var resultSummary: some View {
        ModuleCard {
            HStack(spacing: 28) {
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.08), lineWidth: 11)

                    Circle()
                        .trim(from: 0, to: CGFloat(percentage) / 100)
                        .stroke(
                            scoreColor,
                            style: StrokeStyle(lineWidth: 11, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))

                    VStack(spacing: 1) {
                        Text("\(correctCount)/\(questions.count)")
                            .font(.system(size: 28, weight: .black, design: .rounded))
                            .foregroundStyle(AppTheme.warmWhite)
                        Text("\(percentage) %")
                            .font(.system(size: 12, weight: .bold, design: .monospaced))
                            .foregroundStyle(scoreColor)
                    }
                }
                .frame(width: 126, height: 126)

                VStack(alignment: .leading, spacing: 10) {
                    LessonEyebrow(text: "Resultado final")
                    Text(resultTitle)
                        .font(.system(size: 29, weight: .heavy, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                    Text(resultMessage)
                        .font(.system(size: 13.5, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.mutedText)
                        .lineSpacing(3)
                        .fixedSize(horizontal: false, vertical: true)

                    HStack(spacing: 16) {
                        Label("\(correctCount) correctas", systemImage: "checkmark.circle.fill")
                            .foregroundStyle(AppTheme.success)
                        Label("\(incorrectCount) por revisar", systemImage: "book.pages.fill")
                            .foregroundStyle(incorrectCount == 0 ? AppTheme.mutedText : AppTheme.softGold)
                    }
                    .font(.system(size: 11.5, weight: .bold, design: .rounded))
                }

                Spacer(minLength: 10)

                VStack(spacing: 10) {
                    Button(action: onRetry) {
                        Label("Intentar otra evaluación", systemImage: "arrow.clockwise")
                            .font(.system(size: 12.5, weight: .bold, design: .rounded))
                            .foregroundStyle(AppTheme.deepNavy)
                            .padding(.horizontal, 18)
                            .frame(height: 42)
                            .background(AppTheme.gold)
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)

                    Button(action: onExit) {
                        Label("Volver a la portada", systemImage: "house.fill")
                            .font(.system(size: 11.5, weight: .semibold, design: .rounded))
                            .foregroundStyle(AppTheme.warmWhite)
                            .padding(.horizontal, 18)
                            .frame(height: 38)
                            .background(Color.white.opacity(0.07))
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var scoreColor: Color {
        correctCount >= 7 ? AppTheme.success : (correctCount >= 5 ? AppTheme.softGold : AppTheme.error)
    }

    private var resultTitle: String {
        switch correctCount {
        case 9...10: return "Excelente dominio"
        case 7...8: return "Buen trabajo"
        case 5...6: return "Tienes una base funcional"
        default: return "Es momento de reforzar"
        }
    }

    private var resultMessage: String {
        switch correctCount {
        case 9...10:
            return "Puedes justificar límites desde varias representaciones. Revisa cualquier detalle pendiente para cerrar con todo."
        case 7...8:
            return "Revisa los errores señalados para consolidar los detalles y vuelve a intentarlo cuando estés listo."
        case 5...6:
            return "Ya tienes una base útil, pero conviene repasar los módulos recomendados antes del siguiente intento."
        default:
            return "Repasa los conceptos fundamentales y vuelve a intentarlo. Cada error incluye una explicación y una ruta de estudio."
        }
    }
}

private struct EvaluationReviewCard: View {
    let number: Int
    let question: EvaluationQuestion
    let selectedOptionID: String?
    let onStudyModule: () -> Void

    private var isCorrect: Bool {
        selectedOptionID == question.correctOptionID
    }

    private var selectedOption: EvaluationOption? {
        question.option(withID: selectedOptionID)
    }

    var body: some View {
        ModuleCard {
            VStack(alignment: .leading, spacing: 13) {
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .font(.system(size: 21, weight: .bold))
                        .foregroundStyle(isCorrect ? AppTheme.success : AppTheme.error)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("PREGUNTA \(number) · MÓDULO \(question.moduleNumber)")
                            .font(.system(size: 9.5, weight: .bold, design: .rounded))
                            .tracking(1.4)
                            .foregroundStyle(isCorrect ? AppTheme.success : AppTheme.error)
                        Text(question.prompt)
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundStyle(AppTheme.warmWhite)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    Spacer()

                    Text(isCorrect ? "CORRECTA" : "POR REVISAR")
                        .font(.system(size: 9, weight: .black, design: .rounded))
                        .foregroundStyle(isCorrect ? AppTheme.success : AppTheme.error)
                        .padding(.horizontal, 10)
                        .frame(height: 25)
                        .background((isCorrect ? AppTheme.success : AppTheme.error).opacity(0.12))
                        .clipShape(Capsule())
                }

                if isCorrect {
                    answerRow(label: "Tu respuesta", value: question.correctOption.text, color: AppTheme.success)
                } else {
                    answerRow(label: "Tu respuesta", value: selectedOption?.text ?? "Sin respuesta", color: AppTheme.error)
                    answerRow(label: "Respuesta correcta", value: question.correctOption.text, color: AppTheme.success)

                    if let feedback = selectedOption?.incorrectFeedback {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("¿QUÉ OCURRIÓ?")
                                .font(.system(size: 9, weight: .bold, design: .rounded))
                                .tracking(1.3)
                                .foregroundStyle(AppTheme.softGold)
                            Text(feedback)
                                .font(.system(size: 12, weight: .medium, design: .rounded))
                                .foregroundStyle(AppTheme.warmWhite)
                                .lineSpacing(2)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(AppTheme.gold.opacity(0.075))
                        .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
                    }
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text("EXPLICACIÓN")
                        .font(.system(size: 9, weight: .bold, design: .rounded))
                        .tracking(1.3)
                        .foregroundStyle(AppTheme.lightBlue)
                    Text(question.explanation)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.mutedText)
                        .lineSpacing(2)
                        .fixedSize(horizontal: false, vertical: true)
                }

                HStack(spacing: 12) {
                    Label("Módulo \(question.moduleNumber) — \(question.moduleTitle)", systemImage: "bookmark.fill")
                        .font(.system(size: 10.5, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.softGold)

                    Text(question.studyRoute)
                        .font(.system(size: 10.5, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.mutedText)

                    Spacer()

                    Button(action: onStudyModule) {
                        Label("Volver a estudiar", systemImage: "arrow.up.right")
                            .font(.system(size: 10.5, weight: .bold, design: .rounded))
                            .foregroundStyle(AppTheme.deepNavy)
                            .padding(.horizontal, 13)
                            .frame(height: 34)
                            .background(AppTheme.softGold)
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private func answerRow(label: String, value: String, color: Color) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Text(label + ":")
                .font(.system(size: 10.5, weight: .bold, design: .rounded))
                .foregroundStyle(color)
                .frame(width: 112, alignment: .leading)
            Text(value)
                .font(.system(size: 11.5, weight: .semibold, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
    }
}

