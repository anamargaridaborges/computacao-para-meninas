import SwiftUI

struct HistoriaView: View {
    @State private var historiaViewModel: HistoriaViewModel
    @Environment(\.dismiss) var dismiss

    let idAtividade: String

    init(historiaViewModel: HistoriaViewModel, idAtividade: String) {
        self.idAtividade = idAtividade
        self.historiaViewModel = historiaViewModel
    }
    

    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()

            switch historiaViewModel.noAtual.tipo {

            case .dialogo, .escolha:
                DialogoView(
                    viewModel: historiaViewModel,
                    no: historiaViewModel.noAtual
                )
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))

            case .fim:
                FimDaHistoriaView(
                    mensagem: historiaViewModel.noAtual.mensagemFinal ?? "Você terminou a história!",
                    aoFechar: {
                        historiaViewModel.onConcluirAtividade()
                        dismiss()
                    }
                )
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.35), value: historiaViewModel.noAtual.id)
        .navigationBarBackButtonHidden()
        .safeAreaInset(edge: .top) {
            BarraSuperiorHistoria(aoVoltar: { dismiss() })
        }
    }
}


private struct BarraSuperiorHistoria: View {
    let aoVoltar: () -> Void

    var body: some View {
        HStack {
            Button(action: aoVoltar) {
                Image("ActivityBack")
            }
            .padding()
            Spacer()
            Text("O Desafio dos Tipos")
                .font(.system(.subheadline, design: .rounded, weight: .bold))
                .foregroundStyle(Color.black)
            Spacer()
            Color.clear.frame(width: 44, height: 44)
        }
        .background(Color("AccentColor").opacity(0.15))
    }
}

private struct FimDaHistoriaView: View {
    let mensagem: String
    let aoFechar: () -> Void

    var body: some View {
        VStack(spacing: 28) {
            Spacer()

            Image("AdaComemorando")
                .resizable()
                .scaledToFit()
                .frame(width: 160)

            Text(mensagem)
                .font(.system(.title3, design: .rounded, weight: .bold))
                .foregroundStyle(Color("Text"))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            Spacer()

            Button(action: aoFechar) {
                BotaoContinuar(texto: "Voltar à trilha")
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
        }
    }
}
