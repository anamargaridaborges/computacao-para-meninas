import SwiftUI



struct ExercicioOrdenarView: View {
    @Environment(\.dismiss) var dismiss
    
    let idAtividade: String
    var aoConcluirRodada: () -> Void
    let idExercicio: Int
    let numeroExercicios: Int
    let exercicioAtual: Int
    
    @State var draggedItem: String? = nil
    @State var targetIndex: Int? = nil
    @State var currentDragOffset: CGSize = .zero
    @State var listTopY: CGFloat = 0
    @State var dragStartY: CGFloat = 0
    
    let vetor: [String]
    let rowHeight: CGFloat = 50
    let rowSpacing: CGFloat = 8
    var stride: CGFloat { rowHeight + rowSpacing }
    
    let hapticGenerator = UIImpactFeedbackGenerator(style: .light)
    
    
    @State var lines = [
        "numero = input()",
        "if(numero  > 10 ):",
        "       print(\"O número é grande!\")",
        "else:",
        "       print(\"O número é pequeno.\")"
    ]

    init(
        idAtividade: String,
        aoConcluirRodada: @escaping () -> Void,
        idExercicio: Int,
        numeroExercicios: Int,
        exercicioAtual: Int,
        vetor: [String]
    ) {
        self.idAtividade = idAtividade
        self.aoConcluirRodada = aoConcluirRodada
        self.idExercicio = idExercicio
        self.numeroExercicios = numeroExercicios
        self.exercicioAtual = exercicioAtual
        self.vetor = vetor
        
        _lines = State(initialValue: vetor.shuffled())
        
        hapticGenerator.prepare()
    }
    
    var body: some View {
            VStack {
                HStack {
                    // se clicar em voltar, sai de tudo e volta para a home
                    Button (action: { dismiss() }) {
                        Image("ActivityBack")
                    }
                    .padding()
                    Spacer()
                    BarraDeProgresso(numeroExercicios: numeroExercicios, exercicioAtual: exercicioAtual)
                    Spacer()
                    Button (action: {}) {
                        Image("Doubt")
                    }
                    .padding()
                }
                HStack {
                    Text(exercicios[idExercicio].enunciado)
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                    Spacer()
                }
                .padding()

                VStack(spacing: rowSpacing) {
                    // Ajuste de performance: ForEach id: \.self nos índices
                    ForEach(0...lines.count, id: \.self) { index in
                        if draggedItem != nil && targetIndex == index {
                            DropPlaceholder()
                                .transition(.asymmetric(
                                    insertion: .scale(scale: 0.97).combined(with: .opacity),
                                    removal: .opacity
                                ))
                        }

                        if index < lines.count {
                            CodeRow(text: lines[index])
                                .opacity(draggedItem == lines[index] ? 0 : 1) // Melhora o flicker
                                .gesture(dragGesture(for: index))
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .background(
                    GeometryReader { geo in
                        Color.clear.onAppear {
                            listTopY = geo.frame(in: .named("list")).minY
                        }
                    }
                )
                
                Button(action: {
                    aoConcluirRodada()
                }) {
                    BotaoContinuar(texto: "Checar")
                }
                .padding()
            }
            .coordinateSpace(name: "list")
            .overlay {
                if let item = draggedItem, let to = targetIndex {
                    floatingRow(text: item, atIndex: to)
                }
            }
            .navigationBarBackButtonHidden()
            .navigationBarBackButtonHidden()
    }
    
    func dragGesture(for index: Int) -> some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .named("list"))
            .onChanged { value in
                if draggedItem == nil {
                    // Mudança: .interactiveSpring() é muito mais performático para drag
                    withAnimation(.interactiveSpring(response: 0.22, dampingFraction: 0.75)) {
                        draggedItem = lines.remove(at: index)
                        targetIndex = index
                        currentDragOffset = .zero
                        dragStartY = value.startLocation.y
                    }
                }

                currentDragOffset = value.translation

                let absoluteY = dragStartY + value.translation.height
                let proposed = Int(round((absoluteY - listTopY) / stride))
                    .clamped(to: 0...lines.count)

                if proposed != targetIndex {
                    // Mudança: .interactiveSpring() aqui também
                    withAnimation(.interactiveSpring(response: 0.26, dampingFraction: 0.72)) {
                        targetIndex = proposed
                    }
                    hapticGenerator.impactOccurred()
                }
            }
            .onEnded { _ in
//                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                    if let item = draggedItem, let to = targetIndex {
                        lines.insert(item, at: to.clamped(to: 0...lines.count))
                    }
                    draggedItem = nil
                    targetIndex = nil
                    currentDragOffset = .zero
                    dragStartY = 0
//                }
                    hapticGenerator.impactOccurred()
            }
    }

    // MARK: - Floating ghost row

    func floatingRow(text: String, atIndex: Int) -> some View {
        return CodeRow(text: text)
            .frame(width: UIScreen.main.bounds.width - 40)
            .scaleEffect(1.04)
            .shadow(color: .black.opacity(0.18), radius: 10, y: 5)
            .position(
                x: UIScreen.main.bounds.width / 2,
                y: dragStartY + currentDragOffset.height
            )
            .allowsHitTesting(false)
    }

}

// MARK: - CodeRow (Mantido Original)

struct CodeRow: View {
    let text: String

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .border(.gray.opacity(0.3), width: 1)
            .frame(height: 60)
            .overlay(
                HStack(spacing: 10) {
                    Image(systemName: "line.3.horizontal")
                        .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.2))
                    Text(text)
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.65)
                    Spacer()
                }
                .padding(.horizontal, 12)
            )
    }
}

// MARK: - DropPlaceholder (Mantido Original)

struct DropPlaceholder: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .strokeBorder(
                Color("AccentColor"),
                style: StrokeStyle(lineWidth: 2, dash: [6, 4])
            )
            .frame(height: 50)
    }
}

// MARK: - Helpers

extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}
