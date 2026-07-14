import SwiftUI

@Observable
class OrdenarViewModel {
    let numeroExercicios: Int
    let vetor: [String]
    let explicacao: String
    let aoConcluirRodada: () -> Void

    var lines: [String]
    var draggedItem: String? = nil
    var draggedIndex: Int? = nil
    var targetIndex: Int? = nil
    var currentDragOffset: CGSize = .zero
    var listTopY: CGFloat = 0
    var dragStartY: CGFloat = 0

    var estadoFeedback: EstadoFeedback = .neutro
    
    let rowHeight: CGFloat = 50
    let rowSpacing: CGFloat = 8
    var stride: CGFloat { rowHeight + rowSpacing }

    private let hapticGenerator = UIImpactFeedbackGenerator(style: .light)

    init(
        numeroExercicios: Int,
        vetor: [String],
        explicacao: String = "",
        aoConcluirRodada: @escaping () -> Void
    ) {
        self.numeroExercicios = numeroExercicios
        self.vetor = vetor
        self.explicacao = explicacao
        self.aoConcluirRodada = aoConcluirRodada
        self.lines = vetor.shuffled()
        hapticGenerator.prepare()
    }

    func onDragChanged(_ value: DragGesture.Value, index: Int) {
        if draggedItem == nil {
            withAnimation(.interactiveSpring(response: 0.22, dampingFraction: 0.75)) {
                draggedItem = lines[index]
                targetIndex = index
                draggedIndex = index
                currentDragOffset = .zero
                dragStartY = value.startLocation.y
            }
        }

        currentDragOffset = value.translation

        let absoluteY = dragStartY + value.translation.height
        let proposed = Int(round((absoluteY - listTopY) / stride))
            .clamped(to: 0...lines.count)

        if proposed != targetIndex {
            withAnimation(.interactiveSpring(response: 0.26, dampingFraction: 0.72)) {
                targetIndex = proposed
            }
            hapticGenerator.impactOccurred()
        }
    }

    func commitDrag() {
        guard let item = draggedItem,
              let to = targetIndex,
              let from = draggedIndex else { return }

        lines.remove(at: from)
        lines.insert(item, at: to.clamped(to: 0...lines.count))
        resetDragState()
        hapticGenerator.impactOccurred()
    }

    private func resetDragState() {
        draggedItem = nil
        draggedIndex = nil
        targetIndex = nil
        currentDragOffset = .zero
        dragStartY = 0
    }

    func checar() {
        withAnimation {
            estadoFeedback = (lines == vetor) ? .acerto : .erro
        }
    }

    func aoTocarFeedback() {
        if estadoFeedback == .acerto {
            aoConcluirRodada()
        }
        withAnimation { estadoFeedback = .neutro }
    }
}

fileprivate extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}
