import SwiftUI

struct TrilhaView: View {
    @State private var viewModel = TrilhaViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background").ignoresSafeArea()
                
                VStack(spacing: 0) {
                    headerView
                    
                    Rectangle()
                        .fill(Color("Text"))
                        .frame(height: 3)
                    
                    ScrollView {
                        VStack(spacing: 8) {
                            CardModoSpeedrun()
                            moduloTitleView
                            
                            Spacer()
                            
                            ForEach(viewModel.botoesTrilha) { botao in
                                let estaLivre = viewModel.estaDesbloqueada(idAtividade: botao.id, idDependencia: botao.idDependencia)
                                
                                navigationLinkDestination(botao: botao, estaLivre: estaLivre)
                                    .accessibilityIdentifier("activity_\(botao.id)")
                                    .accessibilityAddTraits(.isButton)
                                    .disabled(!estaLivre)
                                    .offset(x: botao.offsetX)
                                    .padding(.top, botao.id == "historia_1" ? 70 : 0)
                                
                                subViewsEspeciais(apos: botao.id)
                            }
                        }
                        .padding(.top, 16)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
    }

    private var headerView: some View {
        HStack {
            Text("Olá, Ana!")
                .font(.system(.title2, design: .rounded).weight(.bold))
                .foregroundStyle(Color("Text"))
            
            Spacer()
            
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .foregroundStyle(.orange)
                
                Text("\(viewModel.pontosTotais) XP")
                    .font(.system(.headline, design: .rounded).weight(.bold))
                    .foregroundStyle(Color("Text"))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(UIColor.systemBackground).opacity(0.8))
            .clipShape(Capsule())
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(Color("AccentColor").opacity(0.25))
    }

    private var moduloTitleView: some View {
        HStack {
            VStack { Divider() }
            Text("Lógica Computacional")
                .font(.system(.title3, design: .rounded, weight: .bold))
                .foregroundStyle(Color("Text").opacity(0.5))
                .padding(.horizontal, 8)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .layoutPriority(1)
            
            VStack { Divider() }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }

    @ViewBuilder
    private func navigationLinkDestination(botao: BotaoTrilha, estaLivre: Bool) -> some View {
        switch botao.tipo {
        case .historia:
            let historia = carregarHistoria("HistoriaData.json")
            let historiaViewModel = HistoriaViewModel(historia: historia) {
                viewModel.concluirAtividade(id: botao.id)
            }
            NavigationLink(destination: HistoriaView(historiaViewModel: historiaViewModel, idAtividade: botao.id)) {
                BotaoTrilhaView(icone: botao.icone, titulo: botao.titulo, estaLivre: estaLivre, isHistoria: true)
            }
            
        case .exercicio:
            if let exercicios = loadExercisesForActivity(idAtividade: botao.id) {
                let geralViewModel = ExercicioGeralViewModel(exercicios: exercicios) {
                    viewModel.concluirAtividade(id: botao.id)
                }
                NavigationLink(destination: ExercicioGeralView(viewModel: geralViewModel)) {
                    BotaoTrilhaView(icone: botao.icone, titulo: botao.titulo, estaLivre: estaLivre, isHistoria: false)
                }
            }
        }
    }

    @ViewBuilder
    private func subViewsEspeciais(apos id: String) -> some View {
        if id == "atv_2" {
            let ex3Livre = viewModel.estaDesbloqueada(idAtividade: "atv_3", idDependencia: "atv_2")
            HStack(alignment: .bottom) {
                Image("AdaLovelace")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .padding(.leading, 30)
                    .offset(y: -80)
                
                Spacer()
                
                NavigationLink(destination: ExercicioGeralView(viewModel: ExercicioGeralViewModel(exercicios: [], onConcluirAtividade: {}), rodadaAtual: 0)) {
                    BotaoTrilhaView(icone: "}", titulo: "Exercicio 3", estaLivre: ex3Livre, isHistoria: false)
                }
                .disabled(!ex3Livre)
                .padding(.trailing, 100)
                .padding(.bottom, 70)
            }
        } else if id == "historia_1" {
            HStack(alignment: .bottom) {
                Image("Katherine.Johnson")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .padding(.leading, 30)
                    .offset(y: -200)
                    .offset(x: 180)
                
                Spacer()
            }
        }
    }
}

#Preview {
    TrilhaView()
}
