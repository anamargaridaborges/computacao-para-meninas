struct Atividade: Identifiable, Codable {
    var id: String
    var nome: String
    var idExercicios: [Int]
}
