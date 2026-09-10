import SwiftUI

struct ModuleOneConceptView: View {
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 840 {
                        HStack(alignment: .top, spacing: 28) {
                            definitionColumn
                                .frame(maxWidth: .infinity)
                            conceptColumn
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        VStack(spacing: 24) {
                            definitionColumn
                            conceptColumn
                        }
                    }
                }
                .frame(maxWidth: 1_040)
                .padding(.horizontal, 48)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var definitionColumn: some View {
        VStack(alignment: .leading, spacing: 18) {
            LessonEyebrow(text: "Screen 1 · Understand")

            Text("What Is a Limit?")
                .font(.system(size: 38, weight: .heavy, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            Text("A limit describes the value a function approaches as the independent variable gets closer to a target point.")
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .foregroundStyle(AppTheme.mutedText)
                .lineSpacing(5)
                .fixedSize(horizontal: false, vertical: true)

            ModuleCard {
                VStack(spacing: 13) {
                    Text("limₓ→ₐ  f(x) = L")
                        .font(.system(size: 34, weight: .semibold, design: .serif))
                        .foregroundStyle(AppTheme.warmWhite)

                    Rectangle()
                        .fill(AppTheme.gold.opacity(0.55))
                        .frame(height: 1)

                    Text("As x approaches a, the values of f(x) approach L.")
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundStyle(AppTheme.softGold)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
            }

            ModuleCard {
                VStack(alignment: .leading, spacing: 12) {
                    Label("Imagine walking toward a door", systemImage: "figure.walk")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.warmWhite)

                    Text("Each step reduces the distance: 1 m, ½ m, ¼ m, ⅛ m… Your position approaches the door even if you decide not to touch it.")
                        .font(.system(size: 12.5, design: .rounded))
                        .foregroundStyle(AppTheme.mutedText)
                        .fixedSize(horizontal: false, vertical: true)

                    ApproachAnalogyView()
                        .frame(height: 100)
                }
            }
        }
    }

    private var conceptColumn: some View {
        VStack(alignment: .leading, spacing: 18) {
            LessonEyebrow(text: "Essential concepts")

            Text("The Parts of the Idea")
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .foregroundStyle(AppTheme.warmWhite)

            LazyVGrid(columns: columns, spacing: 12) {
                ConceptTile(
                    symbol: "x",
                    title: "Independent variable",
                    explanation: "The value we control and move toward the target."
                )

                ConceptTile(
                    symbol: "a",
                    title: "Target value",
                    explanation: "The point that x approaches."
                )

                ConceptTile(
                    symbol: "→",
                    title: "Approach",
                    explanation: "It means getting closer; reaching the exact point is not required."
                )

                ConceptTile(
                    symbol: "L",
                    title: "Limit value",
                    explanation: "The value approached by the outputs of f(x)."
                )
            }

            ModuleCard {
                HStack(alignment: .top, spacing: 15) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(AppTheme.softGold)

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Key idea")
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                            .foregroundStyle(AppTheme.softGold)

                        Text("We care about the behavior around the point, not only what happens exactly at that point.")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundStyle(AppTheme.warmWhite)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
    }
}
