import Foundation

struct Modulo: Identifiable, Codable {
    var id: UUID = UUID()
    var nome: String
    var atividades: [Atividade]
}
