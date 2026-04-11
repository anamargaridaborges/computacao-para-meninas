//
//  TelaInicial.swift
//  computacao-para-meninas
//
//  Created by Lara Matias Pasquotti on 10/04/26.
//

import SwiftUI

struct HomeView: View {
    
    let nomeModulo: String = "Variáveis"
    
    struct BotaoTrilha {
        let titulo: String
        let icone: String
        let desbloqueado: Bool
        let destino: AnyView
    }
    
    var botoesTrilha: [BotaoTrilha] {
        [
            BotaoTrilha(
                titulo: "Exercício 1",
                icone: "</>",
                desbloqueado: true,
                destino: AnyView(ExercicioGeralView(idx: 0))
            ),
            BotaoTrilha(
                titulo: "Exercício 2",
                icone: "#",
                desbloqueado: false,
                destino: AnyView(EmptyView())
            ),
            BotaoTrilha(
                titulo: "Exercício 3",
                icone: "{ }",
                desbloqueado: false,
                destino: AnyView(EmptyView())
            ),
        ]
    }
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                //Cor de fundo
                Color("Background").ignoresSafeArea()
                
                //Topo da tela
                VStack(spacing: 0) {
                    HStack {
                        Text("Olá, seja bem-vinda!")
                            .font(.system(.title2, design: .rounded, weight: .bold))
                            .foregroundStyle(Color("Text"))
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .background(Color("AccentColor").opacity(0.25))
                    
                    Rectangle()
                        .fill(Color("Text"))
                        .frame(height: 3)
                    
                    //Início das trilhas
                    HStack {
                        VStack { Divider() }
                        Text(nomeModulo)
                            .font(.system(.title3, design: .rounded, weight: .bold))
                            .foregroundStyle(Color("Text").opacity(0.5))
                            .padding(.horizontal, 8)
                        VStack { Divider() }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                    
                    //Trilha
                    ScrollView {
                        VStack(spacing: 24) {
                            ForEach(Array(botoesTrilha.enumerated()), id: \.offset) { index, botao in
                                HStack {
                                    if index % 2 != 0 { Spacer() }
                                    
                                    NavigationLink(destination: botao.destino) {
                                        VStack(spacing: 8) {
                                            ZStack {
                                                // Sombra inferior botão
                                                RoundedRectangle(cornerRadius: 16)
                                                    .fill(botao.desbloqueado ? Color("Color2Button") : Color("Gray"))
                                                    .frame(width: 80, height: 80)
                                                    .offset(x: 5, y: 5)  // ← adiciona o x: 5
                                                
                                                // Tecla principal
                                                RoundedRectangle(cornerRadius: 16)
                                                    .fill(botao.desbloqueado ? Color("Color1Button") : Color("Color3Button"))
                                                    .frame(width: 80, height: 80)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 16)
                                                            .stroke(
                                                                botao.desbloqueado ? Color("Color2Button") : Color("Gray"),
                                                                lineWidth: 3
                                                            )
                                                    )
                                                
                                                Text(botao.icone)
                                                    .font(.system(size: 32, weight: .bold, design: .rounded))
                                                    .foregroundStyle(Color.black)
                                            }
                                            Text(botao.titulo)
                                                .font(.system(.caption, design: .rounded, weight: .bold))
                                                .foregroundStyle(botao.desbloqueado ? Color("AccentColor") : Color("Gray"))
                                        }
                                    }
                                    .disabled(!botao.desbloqueado)
                                    
                                    if index % 2 == 0 { Spacer() }
                                }
                                .padding(.horizontal, 60)
                            }
                        }
                        .padding(.top, 16)
                        .padding(.bottom, 40)
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
