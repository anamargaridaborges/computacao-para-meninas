import SwiftUI

extension Exercicio {
    func criarView(exercicio: Exercicio, rodadaAtual: Int, aoConcluirRodada: @escaping () -> Void) -> AnyView {
        switch self.tipo {
        case .ordenar(let vetor):
            let vm = OrdenarViewModel(
                numeroExercicios: rodadaAtual,
                vetor: vetor,
                explicacao: exercicio.explicacao,
                aoConcluirRodada: aoConcluirRodada
            )
            return AnyView(
                ExercicioOrdenarView(ordenarViewModel: vm).id(rodadaAtual)
            )
        case .relacionarColunas(let primeiro, let segundo):
            let vm = RelacionarColunasViewModel(
                vetor1: primeiro,
                vetor2: segundo,
                exercicio: exercicio,
                aoConcluirRodada: aoConcluirRodada
            )
            return AnyView(
                RelacionarColunasView(viewModel: vm).id(rodadaAtual)
            )
        case .multiplaEscolha(let resposta, let codigo):
            let vm = MultiplaEscolhaViewModel(
                resposta: resposta,
                codigo: codigo,
                exercicio: exercicio,
                onConcluirAtividade: aoConcluirRodada
            )
            return AnyView(
                MultiplaEscolhaView(viewModel: vm, resposta: resposta, codigo: codigo).id(rodadaAtual)
            )
        case .curiosidade(let conteudo):
            return AnyView(
                ExercicioCuriosidadeView(aoConcluirRodada: aoConcluirRodada, curiosidade: conteudo)
            )
        case .conteudoTeorico(let texto, let imagem, let dica):
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
}
