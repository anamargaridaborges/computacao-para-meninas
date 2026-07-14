import SwiftUI

struct Exercicio: Decodable {
    var tipo: TipoExercicio
    var enunciado: String
    var alternativas: [String]
    var explicacao: String
}
