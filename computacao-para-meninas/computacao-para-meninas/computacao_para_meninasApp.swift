//
//  computacao_para_meninasApp.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 07/04/26.
//

import SwiftUI
import SwiftData

@main
struct computacao_para_meninasApp: App {

    var body: some Scene {
        WindowGroup {
            Exercicio3View(idExercicio: 0, numeroExercicios: 5, exercicioAtual: 1)
        }
    }
}
