//
//  TelaInicial.swift
//  computacao-para-meninas
//
//  Created by Lara Matias Pasquotti on 10/04/26.
//

import SwiftUI

struct HomeView: View {
    
    let nomeModulo: String = "Variáveis"
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                //Cor de fundo
                Color("Background").ignoresSafeArea()
                
                //Topo da tela
                VStack(spacing: 0) {
                    HStack {
                        Text("Olá, seja bem-vinda!")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(Color("Text"))
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .background(Color("AccentColor").opacity(0.25))

                    //Início das trilhas
                    HStack {
                        VStack { Divider() }
                        Text(nomeModulo)
                            .font(.subheadline)
                            .foregroundStyle(Color.secondary)
                            .padding(.horizontal, 8)
                        VStack { Divider() }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                    
                    Spacer()
                }
                
                
            }
        }
        
    }
}

#Preview {
    HomeView()
}
