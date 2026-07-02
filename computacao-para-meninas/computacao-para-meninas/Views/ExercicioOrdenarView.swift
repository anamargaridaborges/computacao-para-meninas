import SwiftUI

struct ExercicioOrdenarView: View {
    @Environment(\.dismiss) var dismiss

    @State private var viewModel: OrdenarViewModel
    @GestureState private var isDragging: Bool = false

    init(ordenarViewModel: OrdenarViewModel) {
        _viewModel = State(initialValue: ordenarViewModel)
    }

    var body: some View {
        VStack {
            VStack(spacing: viewModel.rowSpacing) {
                ForEach(0...viewModel.lines.count, id: \.self) { index in
                    if viewModel.draggedItem != nil,
                       viewModel.targetIndex == index,
                       index != viewModel.draggedIndex,
                       let draggedIndex = viewModel.draggedIndex,
                       index != draggedIndex + 1 {
                        DropPlaceholder()
                            .transition(.asymmetric(
                                insertion: .scale(scale: 0.97).combined(with: .opacity),
                                removal: .opacity
                            ))
                    }

                    if index < viewModel.lines.count {
                        CodeRow(text: viewModel.lines[index])
                            .gesture(dragGesture(for: index))
                            .opacity(viewModel.draggedIndex == index ? 0 : 1)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .background(
                GeometryReader { geo in
                    Color.clear.onAppear {
                        viewModel.listTopY = geo.frame(in: .named("list")).minY
                    }
                }
            )

            if viewModel.estadoFeedback == .neutro {
                Button(action: { viewModel.checar() }) {
                    BotaoContinuar(texto: "Checar")
                }
                .padding()
            }
        }
        .coordinateSpace(name: "list")
        .overlay {
            if let item = viewModel.draggedItem, let to = viewModel.targetIndex {
                floatingRow(text: item, atIndex: to)
            }
        }
        .onChange(of: isDragging) {
            if !isDragging {
                viewModel.commitDrag()
            }
        }
        .navigationBarBackButtonHidden()
        .animation(.spring(response: 0.35), value: viewModel.estadoFeedback)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            if viewModel.estadoFeedback != .neutro {
                BarraFeedback(
                    mensagem: viewModel.mensagemFeedback,
                    estado: viewModel.estadoFeedback,
                    aoTocar: { viewModel.aoTocarFeedback() }
                )
                .ignoresSafeArea(edges: .bottom)
                .transition(.move(edge: .bottom))
            }
        }
    }

    func dragGesture(for index: Int) -> some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .named("list"))
            .updating($isDragging) { _, state, _ in
                state = true
            }
            .onChanged { value in
                viewModel.onDragChanged(value, index: index)
            }
            .onEnded { _ in
                viewModel.commitDrag()
            }
    }

    func floatingRow(text: String, atIndex: Int) -> some View {
        CodeRow(text: text)
            .frame(width: UIScreen.main.bounds.width - 40)
            .scaleEffect(1.04)
            .shadow(color: .black.opacity(0.18), radius: 10, y: 5)
            .position(
                x: UIScreen.main.bounds.width / 2,
                y: viewModel.dragStartY + viewModel.currentDragOffset.height
            )
            .allowsHitTesting(false)
    }
}

fileprivate struct CodeRow: View {
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

fileprivate struct DropPlaceholder: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .strokeBorder(
                Color("AccentColor"),
                style: StrokeStyle(lineWidth: 2, dash: [6, 4])
            )
            .frame(height: 50)
    }
}
