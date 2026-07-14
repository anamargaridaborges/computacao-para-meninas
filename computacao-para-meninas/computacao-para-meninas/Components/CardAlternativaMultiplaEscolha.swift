import SwiftUI

struct CardAlternativaMultiplaEscolha: View {
    enum Estado {
        case normal
        case selecionado
        case acerto
        case erro
    }
    
    let estado: Estado
    let texto: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(estado == .acerto ? Color("LightGreen") : Color("LightestGray"))
                .stroke(strokeColor(), lineWidth: (estado == .selecionado ? 4 : 2))
                .frame(width: 100, height: 80)
            Text(texto)
                .foregroundStyle(estado == .acerto ? Color("DarkGreen") : Color.black)
                .frame(width: 80)
                .multilineTextAlignment(.leading)
                .monospaced()
        }
        .padding(2)
    }

    private func strokeColor() -> Color {
        switch(estado) {
        case .selecionado:
            return Color("AccentColor")
        case .acerto:
            return Color("DarkGreen")
        case .erro:
            return Color("Wrong")
        case .normal:
            return Color("Gray")
        }
    }
}
