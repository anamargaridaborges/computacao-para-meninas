import XCTest
@testable import computacao_para_meninas

final class MultiplaEscolhaViewModelTests: XCTestCase {

    // Helper to build a minimal Exercicio of multiplaEscolha
    private func makeExercicioMultiplaEscolha(resposta: Int = 2, codigo: String = "____ = 100", alternativas: [String] = ["a", "b", "c"]) -> Exercicio {
        let tipo: TipoExercicio = .multiplaEscolha(resposta, codigo)
        return Exercicio(tipo: tipo, enunciado: "Teste", alternativas: alternativas, explicacao: "")
    }

    func testEquivalenceClasses_selectionCorrectVsIncorrect() {
        // Classes de equivalência: seleção correta vs incorreta
        let exercicio = makeExercicioMultiplaEscolha(resposta: 1)
        let vm = MultiplaEscolhaViewModel(resposta: 1, codigo: "", exercicio: exercicio, onConcluirAtividade: {})

        // Incorreta
        vm.selecionar(0)
        vm.verificar()
        XCTAssertEqual(vm.estadoFeedback, .erro)

        // Correta
        vm.resetar()
        vm.selecionar(1)
        vm.verificar()
        XCTAssertEqual(vm.estadoFeedback, .acerto)
    }

    func testBoundaryValues_validIndexRange() {
        // Análise de Valor Limite: índices -1 (abaixo), 0 (limite), último índice (limite superior)
        let alternativas = ["opt0", "opt1", "opt2"]
        let exercicio = makeExercicioMultiplaEscolha(resposta: 2, codigo: "", alternativas: alternativas)
        let vm = MultiplaEscolhaViewModel(resposta: 2, codigo: "", exercicio: exercicio, onConcluirAtividade: {})

        // Abaixo do limite: -1 (estado inicial)
        XCTAssertEqual(vm.idSelecionado, -1)
        vm.verificar()
        XCTAssertEqual(vm.estadoFeedback, .erro, "Sem seleção válida, deve acusar erro ao verificar")

        // No limite inferior: 0
        vm.resetar()
        vm.selecionar(0)
        vm.verificar()
        XCTAssertEqual(vm.estadoFeedback, .erro)

        // No limite superior: último índice = 2
        vm.resetar()
        vm.selecionar(2)
        vm.verificar()
        XCTAssertEqual(vm.estadoFeedback, .acerto)
    }
}
