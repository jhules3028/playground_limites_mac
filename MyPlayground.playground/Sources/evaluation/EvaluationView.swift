import SwiftUI

struct EvaluationView: View {
    @State private var questions: [EvaluationQuestion]
    @State private var answers: [String: String] = [:]
    @State private var currentIndex = 0
    @State private var showsResults = false

    let onExit: () -> Void
    let onPreviousModule: () -> Void
    let onStudyModule: (Int) -> Void
    let onSubmit: () -> Void

    init(
        onExit: @escaping () -> Void,
        onPreviousModule: @escaping () -> Void,
        onStudyModule: @escaping (Int) -> Void,
        onSubmit: @escaping () -> Void
    ) {
        _questions = State(initialValue: EvaluationAttemptFactory.makeAttempt())
        self.onExit = onExit
        self.onPreviousModule = onPreviousModule
        self.onStudyModule = onStudyModule
        self.onSubmit = onSubmit
    }

    var body: some View {
        VStack(spacing: 0) {
            EvaluationHeader(
                currentIndex: currentIndex,
                questions: questions,
                answers: answers,
                showsResults: showsResults,
                onExit: onExit,
                onSelectQuestion: selectQuestion
            )

            if showsResults {
                EvaluationResultsView(
                    questions: questions,
                    answers: answers,
                    onRetry: startNewAttempt,
                    onExit: onExit,
                    onStudyModule: onStudyModule
                )
                .transition(.opacity.combined(with: .move(edge: .bottom)))
            } else if questions.indices.contains(currentIndex) {
                EvaluationQuestionView(
                    question: questions[currentIndex],
                    questionNumber: currentIndex + 1,
                    totalQuestions: questions.count,
                    selectedOptionID: answers[questions[currentIndex].id],
                    onSelectOption: selectOption
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .id(questions[currentIndex].id)
                .transition(.opacity)

                navigation
            }
        }
        .background(evaluationBackground)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(AppTheme.gold.opacity(0.42), lineWidth: 1.2)
                .padding(18)
                .allowsHitTesting(false)
        }
    }

    private var navigation: some View {
        HStack {
            Button(action: showPreviousQuestion) {
                Label(currentIndex == 0 ? "Módulo 6" : "Anterior", systemImage: "arrow.left")
                    .font(.system(size: 13.5, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)
                    .padding(.horizontal, 18)
                    .frame(height: 42)
                    .background(Color.white.opacity(0.075))
                    .clipShape(Capsule())
            }
            .buttonStyle(.plain)

            Spacer()

            VStack(spacing: 3) {
                Text(answers[questions[currentIndex].id] == nil ? "Aún sin respuesta" : "Respuesta guardada")
                    .font(.system(size: 10.5, weight: .bold, design: .rounded))
                    .foregroundStyle(answers[questions[currentIndex].id] == nil ? AppTheme.mutedText : AppTheme.lightBlue)
                Text("Puedes cambiarla antes de entregar")
                    .font(.system(size: 9.5, weight: .medium, design: .rounded))
                    .foregroundStyle(AppTheme.mutedText.opacity(0.8))
            }

            Spacer()

            if currentIndex < questions.count - 1 {
                Button(action: showNextQuestion) {
                    Label("Siguiente", systemImage: "arrow.right")
                        .labelStyle(EvaluationTrailingIconLabelStyle())
                        .font(.system(size: 13.5, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.deepNavy)
                        .padding(.horizontal, 20)
                        .frame(height: 42)
                        .background(AppTheme.gold)
                        .clipShape(Capsule())
                }
                .buttonStyle(.plain)
            } else {
                Button(action: submit) {
                    HStack(spacing: 9) {
                        Text(isComplete ? "Entregar evaluación" : "Faltan \(questions.count - answers.count)")
                        Image(systemName: isComplete ? "paperplane.fill" : "lock.fill")
                    }
                    .font(.system(size: 13.5, weight: .bold, design: .rounded))
                    .foregroundStyle(isComplete ? AppTheme.deepNavy : AppTheme.mutedText)
                    .padding(.horizontal, 20)
                    .frame(height: 42)
                    .background(isComplete ? AppTheme.gold : Color.white.opacity(0.075))
                    .clipShape(Capsule())
                }
                .buttonStyle(.plain)
                .disabled(!isComplete)
            }
        }
        .padding(.horizontal, 48)
        .padding(.top, 12)
        .padding(.bottom, 28)
    }

    private var isComplete: Bool {
        answers.count == questions.count
    }

    private var evaluationBackground: some View {
        ZStack {
            AppTheme.background

            Circle()
                .fill(AppTheme.gold.opacity(0.07))
                .frame(width: 520, height: 520)
                .offset(x: 480, y: -340)

            Circle()
                .fill(AppTheme.lightBlue.opacity(0.08))
                .frame(width: 470, height: 470)
                .offset(x: -500, y: 360)

            Text("10 / 10")
                .font(.system(size: 116, weight: .black, design: .rounded))
                .foregroundStyle(Color.white.opacity(0.015))
                .rotationEffect(.degrees(-7))
                .offset(x: 350, y: 310)
        }
        .ignoresSafeArea()
    }

    private func selectOption(_ optionID: String) {
        guard questions.indices.contains(currentIndex) else { return }
        answers[questions[currentIndex].id] = optionID
    }

    private func selectQuestion(_ index: Int) {
        guard !showsResults, questions.indices.contains(index) else { return }
        withAnimation(.easeInOut(duration: 0.22)) {
            currentIndex = index
        }
    }

    private func showPreviousQuestion() {
        guard currentIndex > 0 else {
            onPreviousModule()
            return
        }
        selectQuestion(currentIndex - 1)
    }

    private func showNextQuestion() {
        guard currentIndex < questions.count - 1 else { return }
        selectQuestion(currentIndex + 1)
    }

    private func submit() {
        guard isComplete else { return }
        onSubmit()
        withAnimation(.easeInOut(duration: 0.35)) {
            showsResults = true
        }
    }

    private func startNewAttempt() {
        withAnimation(.easeInOut(duration: 0.3)) {
            questions = EvaluationAttemptFactory.makeAttempt()
            answers = [:]
            currentIndex = 0
            showsResults = false
        }
    }
}

private struct EvaluationTrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 10) {
            configuration.title
            configuration.icon
        }
    }
}

