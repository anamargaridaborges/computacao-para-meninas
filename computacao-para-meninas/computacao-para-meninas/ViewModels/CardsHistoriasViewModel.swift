import SwiftUI
import Observation

@Observable
class HistoriasViewModel {
    private let chavePontosTotais = "pontosTotaisXP"

    var pontosTotais: Int = 0

    let personagens: [Personagem] = [
        Personagem(
            id: "grace_hopper",
            nome: "Grace Hopper",
            imagem: "Card1",
            historia: [
                "Grace acreditava que computadores deveriam ser fáceis de programar.",
                "Ela ajudou a criar uma das primeiras linguagens de programação modernas e nunca desistia diante de um problema.",
                "Sua frase favorita era: \"A forma mais perigosa de pensar é dizer: sempre fizemos assim.\"",
                "Ela nos ensina que inovar começa quando temos coragem de mudar."
            ],
            pontosNecessarios: 0
        ),
        Personagem(
            id: "katherine_johnson",
            nome: "Katherine Johnson",
            imagem: "Card2",
            historia: [
                "Katherine usa a matemática para resolver desafios que pareciam impossíveis.",
                "Seus cálculos ajudaram astronautas a viajar ao espaço e voltar em segurança.",
                "Mesmo enfrentando preconceitos por ser mulher e negra, ela nunca deixou que isso limitasse seus sonhos.",
                "Sua história mostra que conhecimento e perseverança podem levar alguém muito longe."
            ],
            pontosNecessarios: 150
        ),
        Personagem(
            id: "ada_lovelace",
            nome: "Ada Lovelace",
            imagem: "Card3",
            historia: [
                "Ada viveu em uma época em que poucas mulheres podiam estudar ciência.",
                "Mesmo assim, imaginou que as máquinas poderiam fazer muito mais do que cálculos.",
                "Ela escreveu o primeiro algoritmo pensado para ser executado por uma máquina, tornando-se conhecida como a primeira programadora da história.",
                "Sua imaginação mostrou que grandes ideias podem surgir antes mesmo da tecnologia existir."
            ],
            pontosNecessarios: 300
        ),
        Personagem(
            id: "margaret_hamilton",
            nome: "Margaret Hamilton",
            imagem: "Card4",
            historia: [
                "Margaret liderou a equipe que desenvolveu o software das missões Apollo.",
                "Quando os astronautas pousaram na Lua, seu programa conseguiu lidar com um problema inesperado e evitou que a missão fosse cancelada.",
                "Seu trabalho provou que um bom software pode fazer a diferença nos momentos mais importantes."
            ],
            pontosNecessarios: 450
        )
    ]

    init() {
        carregarProgresso()
    }

    func carregarProgresso() {
        pontosTotais = UserDefaults.standard.integer(forKey: chavePontosTotais)
    }

    func estaDesbloqueada(_ personagem: Personagem) -> Bool {
        personagem.estaDesbloqueada(pontosTotais: pontosTotais)
    }
}
