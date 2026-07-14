import SwiftUI

enum TipoBotaoTrilha {
    case exercicio
    case historia
}

struct BotaoTrilha: Identifiable {
    let id: String
    let idDependencia: String?
    let titulo: String
    let icone: String
    let offsetX: CGFloat
    var tipo: TipoBotaoTrilha = .exercicio
    var usaSFSymbol: Bool = false
}
