import Observation

@Observable
class ExercicioGeralViewModel {
    let onConcluirAtividade: () -> Void
    var exercicios: [Exercicio]
    var rodadaAtual: Int = 0
    
    var concluido: Bool
    
    var exercicioAtual: Exercicio {
        exercicios[rodadaAtual]
    }
    
    var totalRodadas: Int {
        exercicios.count
    }

    init(exercicios: [Exercicio], onConcluirAtividade: @escaping () -> Void) {
        self.onConcluirAtividade = onConcluirAtividade
        self.exercicios = exercicios
        self.concluido = false
    }
    
    func proximaEtapa() {
        if rodadaAtual < totalRodadas - 1 {
            rodadaAtual += 1
        } else {
            onConcluirAtividade()
            concluido = true
        }
    }
}
