import SwiftUI

struct ModuleOneSummaryView: View {
    @State private var selectedAnswer: Bool?

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 860 {
                        HStack(alignment: .top, spacing: 26) {
                            summaryColumn
                                .frame(maxWidth: .infinity)
                            checkpointColumn
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            summaryColumn
                            checkpointColumn
                        }
                    }
                }
                .frame(maxWidth: 1_040)
                .padding(.horizontal, 48)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var summaryColumn: some View {
        VStack(alignment: .leading, spacing: 18) {
            LessonEyebrow(text: "Pantalla 3 · Concluir")

            Text("Qué debes llevarte")
                .font(.system(size: 34, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            VStack(spacing: 11) {
                KeyIdeaRow(
                    number: "01",
                    title: "x se aproxima a a",
                    explanation: "Observamos valores de x alrededor del punto objetivo."
                )
                KeyIdeaRow(
                    number: "02",
                    title: "f(x) se aproxima a L",
                    explanation: "Los resultados muestran una tendencia hacia el valor límite."
                )
                KeyIdeaRow(
                    number: "03",
                    title: "Llegar no es obligatorio",
                    explanation: "El límite puede existir aunque la función no esté definida en a."
                )
            }

            ModuleCard {
                HStack(spacing: 18) {
                    VStack(spacing: 4) {
                        Text("x")
                            .foregroundStyle(AppTheme.lightBlue)
                        Text("→ a")
                            .foregroundStyle(AppTheme.warmWhite)
                    }

                    Image(systemName: "arrow.right")
                        .foregroundStyle(AppTheme.gold)

                    VStack(spacing: 4) {
                        Text("f(x)")
                            .foregroundStyle(AppTheme.softGold)
                        Text("→ L")
                            .foregroundStyle(AppTheme.warmWhite)
                    }
                }
                .font(.system(size: 24, weight: .bold, design: .serif))
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var checkpointColumn: some View {
        VStack(alignment: .leading, spacing: 18) {
            LessonEyebrow(text: "Comprobación rápida")

            ModuleCard {
                VStack(alignment: .leading, spacing: 18) {
                    HStack(spacing: 10) {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(size: 19, weight: .bold))
                            .foregroundStyle(AppTheme.softGold)

                        Text("Antes de continuar")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundStyle(AppTheme.warmWhite)
                    }

                    Text("¿Puede existir el límite de una función en x = a aunque f(a) no esté definida?")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)
                        .fixedSize(horizontal: false, vertical: true)

                    HStack(spacing: 12) {
                        AnswerButton(
                            title: "Sí",
                            isSelected: selectedAnswer == true,
                            color: AppTheme.success
                        ) {
                            selectedAnswer = true
                        }

                        AnswerButton(
                            title: "No",
                            isSelected: selectedAnswer == false,
                            color: AppTheme.error
                        ) {
                            selectedAnswer = false
                        }
                    }

                    if let selectedAnswer {
                        HStack(alignment: .top, spacing: 11) {
                            Image(systemName: selectedAnswer ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundStyle(selectedAnswer ? AppTheme.success : AppTheme.error)

                            Text(
                                selectedAnswer
                                    ? "Correcto. El límite depende de los valores cercanos a a; no exige que f(a) exista."
                                    : "Todavía no. Recuerda el hueco del ejemplo: f(2) no existe, pero los valores cercanos se aproximan a 4."
                            )
                            .font(.system(size: 12.5, weight: .medium, design: .rounded))
                            .foregroundStyle(AppTheme.warmWhite)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(13)
                        .background((selectedAnswer ? AppTheme.success : AppTheme.error).opacity(0.11))
                        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                    }
                }
            }

            ModuleCard {
                HStack(alignment: .top, spacing: 15) {
                    Image(systemName: "quote.opening")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(AppTheme.softGold)

                    VStack(alignment: .leading, spacing: 7) {
                        Text("Idea clave del módulo")
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundStyle(AppTheme.softGold)

                        Text("El límite describe a qué valor se aproxima una función, aunque la función no necesariamente llegue a tomar ese valor.")
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .foregroundStyle(AppTheme.warmWhite)
                            .lineSpacing(4)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }

            Text("Al terminar, continuarás con la representación numérica mediante tablas.")
                .font(.system(size: 11.5, weight: .medium, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
        }
    }
}

private struct KeyIdeaRow: View {
    let number: String
    let title: String
    let explanation: String

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Text(number)
                .font(.system(size: 11, weight: .bold, design: .monospaced))
                .foregroundStyle(AppTheme.softGold)
                .frame(width: 36, height: 36)
                .background(AppTheme.gold.opacity(0.12))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)

                Text(explanation)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(AppTheme.mutedText)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()
        }
        .padding(14)
        .background(Color.white.opacity(0.055))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}

private struct AnswerButton: View {
    let title: String
    let isSelected: Bool
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(isSelected ? AppTheme.deepNavy : AppTheme.warmWhite)
                .frame(maxWidth: .infinity)
                .frame(height: 42)
                .background(isSelected ? color : Color.white.opacity(0.07))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(isSelected ? color : Color.white.opacity(0.11), lineWidth: 1)
                }
        }
        .buttonStyle(.plain)
    }
}
