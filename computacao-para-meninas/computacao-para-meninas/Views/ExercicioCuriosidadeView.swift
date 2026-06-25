//
//  ExercicioCuriosidadeView.swift
//  computacao-para-meninas
//
//  Created by Lucas Peixoto Gonçalves on 25/06/26.
//

import SwiftUI

struct ExercicioCuriosidadeView: View {
    var aoConcluirRodada: () -> Void
    let curiosidade: String
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(curiosidade)
            
            Spacer()
            
            Button(action: {
                aoConcluirRodada()
            }) {
                BotaoContinuar()
            }
        }
        .navigationBarBackButtonHidden()
    }
}
