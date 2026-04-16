//
//  TelaInicial.swift
//  computacao-para-meninas
//
//  Created by Lara Matias Pasquotti on 10/04/26.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = TrilhaViewModel()
    let nomeModulo: String = "Variáveis"
    
    struct BotaoTrilha {
        let id: String
        let idDependencia: String?
        let titulo: String
        let icone: String
        let offsetX: CGFloat
    }
    
    var botoesTrilha: [BotaoTrilha] {
        [
            BotaoTrilha(
                id: "atv_1",
                idDependencia: nil,
                titulo: "Exercício 1",
                icone: "</>",
                offsetX: -80
            ),
            BotaoTrilha(
                id: "atv_2",
                idDependencia: "atv_1",
                titulo: "Exercício 2",
                icone: "#",
                offsetX: 110
            ),
            BotaoTrilha(
                id: "atv_4",
                idDependencia: "atv_3",
                titulo: "Exercício 4",
                icone: "%",
                offsetX: -30
            ),
        ]
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background").ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Topo da tela
                    HStack {
                        Text("Olá, seja bem-vinda!")
                            .font(.system(.title2, design: .rounded, weight: .bold))
                            .foregroundStyle(Color("Text"))
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .background(Color("AccentColor").opacity(0.25))
                    
                    Rectangle().fill(Color("Text")).frame(height: 3)
                    
                    
                    
                    // Trilha
                    ScrollView {
                        VStack(spacing: 8) {
                            // Título do módulo
                            HStack {
                                VStack { Divider() }
                                Text(nomeModulo)
                                    .font(.system(.title3, design: .rounded, weight: .bold))
                                    .foregroundStyle(Color("Text").opacity(0.5))
                                    .padding(.horizontal, 8)
                                VStack { Divider() }
                            }
                            .padding(.horizontal, 20).padding(.top, 24)
                            
                            Spacer()
                            
                            ForEach(Array(botoesTrilha.enumerated()), id: \.offset) { index, botao in
                                
                                let estaLivre = viewModel.estaDesbloqueada(idAtividade: botao.id, idDependencia: botao.idDependencia)
                                
                                NavigationLink(destination: ExercicioGeralView(viewModel: viewModel, idx: 0, idAtividade: botao.id)) {
                                    VStack(spacing: 8) {
                                        ZStack {
                                            // Sombra
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(estaLivre ? Color("Color2Button") : Color("Gray"))
                                                .frame(width: 80, height: 80).offset(x: 5, y: 5)
                                            
                                            // Tecla principal
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(estaLivre ? Color("Color1Button") : Color("Color3Button"))
                                                .frame(width: 80, height: 80)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .stroke(estaLivre ? Color("Color2Button") : Color("Gray"), lineWidth: 3)
                                                )
                                            
                                            Text(botao.icone)
                                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                                .foregroundStyle(Color.black)
                                        }
                                        Text(botao.titulo)
                                            .font(.system(.caption, design: .rounded, weight: .bold))
                                            .foregroundStyle(estaLivre ? Color("AccentColor") : Color("Gray"))
                                    }
                                }
                                .disabled(!estaLivre)
                                .offset(x: botao.offsetX)
                                
                                // Ada e exercício 3
                                if index == 1 {
                                    HStack(alignment: .bottom) {
                                        Image("AdaLovelace")
                                            .resizable().scaledToFit().frame(width: 150)
                                            .padding(.leading, 30).offset(y: -80)
                                        
                                        Spacer()
                                        
                                        let ex3Livre = viewModel.estaDesbloqueada(idAtividade: "atv_3", idDependencia: "atv_2")
                                        
                                        NavigationLink(destination: ExercicioGeralView(viewModel: viewModel, idx: 0, idAtividade: "atv_3")) {
                                            VStack(spacing: 8) {
                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .fill(ex3Livre ? Color("Color2Button") : Color("Gray"))
                                                        .frame(width: 80, height: 80).offset(x: 5, y: 5)
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .fill(ex3Livre ? Color("Color1Button") : Color("Color3Button"))
                                                        .frame(width: 80, height: 80)
                                                        .overlay(
                                                            RoundedRectangle(cornerRadius: 16)
                                                                .stroke(ex3Livre ? Color("Color2Button") : Color("Gray"), lineWidth: 3)
                                                        )
                                                    Text("{ }")
                                                        .font(.system(size: 32, weight: .bold, design: .rounded))
                                                        .foregroundStyle(Color.black)
                                                }
                                                Text("Exercício 3")
                                                    .font(.system(.caption, design: .rounded, weight: .bold))
                                                    .foregroundStyle(ex3Livre ? Color("AccentColor") : Color("Gray"))
                                            }
                                        }
                                        .disabled(!ex3Livre)
                                        .padding(.trailing, 100).padding(.bottom, 70)
                                    }
                                }
                            }
                        }
                        .padding(.top, 16).padding(.bottom, 40)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
