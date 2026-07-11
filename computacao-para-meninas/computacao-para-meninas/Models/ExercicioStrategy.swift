//
//  ExercicioStrategy.swift
//  computacao-para-meninas
//
//  Created by Lucas Peixoto Gonçalves on 30/06/26.
//

import SwiftUI

protocol ExercicioStrategy {
    func criarView(
        exercicio: Exercicio,
        rodadaAtual: Int,
        aoConcluirRodada: @escaping () -> Void
    ) -> AnyView
}


struct OrdenarStrategy: ExercicioStrategy {
    let vetor: [String]

    func criarView(exercicio: Exercicio, rodadaAtual: Int, aoConcluirRodada: @escaping () -> Void) -> AnyView {
        let vm = OrdenarViewModel(
            numeroExercicios: rodadaAtual, // ajuste conforme sua lógica real
            vetor: vetor,
            explicacao: exercicio.explicacao,
            aoConcluirRodada: aoConcluirRodada
        )
        return AnyView(
            ExercicioOrdenarView(ordenarViewModel: vm).id(rodadaAtual)
        )
    }
}

struct RelacionarColunasStrategy: ExercicioStrategy {
    let primeiro: [Int]
    let segundo: [Int]

    func criarView(exercicio: Exercicio, rodadaAtual: Int, aoConcluirRodada: @escaping () -> Void) -> AnyView {
        let vm = RelacionarColunasViewModel(
            vetor1: primeiro,
            vetor2: segundo,
            exercicio: exercicio,
            aoConcluirRodada: aoConcluirRodada
        )
        return AnyView(
            RelacionarColunasView(viewModel: vm).id(rodadaAtual)
        )
    }
}

struct MultiplaEscolhaStrategy: ExercicioStrategy {
    let resposta: Int
    let codigo: String

    func criarView(exercicio: Exercicio, rodadaAtual: Int, aoConcluirRodada: @escaping () -> Void) -> AnyView {
        let vm = MultiplaEscolhaViewModel(
            resposta: resposta,
            codigo: codigo,
            exercicio: exercicio,
            onConcluirAtividade: aoConcluirRodada
        )
        return AnyView(
            MultiplaEscolhaView(viewModel: vm, resposta: resposta, codigo: codigo).id(rodadaAtual)
        )
    }
}

struct CuriosidadeStrategy: ExercicioStrategy {
    let conteudo: String

    func criarView(exercicio: Exercicio, rodadaAtual: Int, aoConcluirRodada: @escaping () -> Void) -> AnyView {
        AnyView(
            ExercicioCuriosidadeView(aoConcluirRodada: aoConcluirRodada, curiosidade: conteudo)
        )
    }
}

struct ConteudoTeoricoStrategy: ExercicioStrategy {
    let texto: String
    let imagem: String?
    let dica: String?

    func criarView(exercicio: Exercicio, rodadaAtual: Int, aoConcluirRodada: @escaping () -> Void) -> AnyView {
        let vm = ExercicioTeoricoViewModel(
            exercicio: exercicio,
            texto: texto,
            imagem: imagem,
            dica: dica,
            onConcluirAtividade: aoConcluirRodada
        )
        return AnyView(
            ExercicioTeoricoView(viewModel: vm).id(rodadaAtual)
        )
    }
}
