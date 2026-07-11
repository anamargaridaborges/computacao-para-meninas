//
//  ModoSpeedrunView.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 10/07/26.
//

import SwiftUI

struct ModoSpeedrunView: View {
    
    @State var tempoRestante: Int = 4
    @State var questoesSpeedrun: [Exercicio] = []
    @State var idxAtual: Int = 0
    
    var body: some View {
        if (tempoRestante > 0) {
            CountdownView(tempoRestante: $tempoRestante)
                .onAppear {
                    questoesSpeedrun = loadIfPresent("ModoSpeedrunQuestoes.json") ?? []
                    questoesSpeedrun = questoesSpeedrun.shuffled()
                }
        }
        else {
            VStack {
                BarraTempoSpeedrun()
                Spacer()
                
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button (action: {}) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
    
    
    
}

#Preview {
    ModoSpeedrunView()
}
