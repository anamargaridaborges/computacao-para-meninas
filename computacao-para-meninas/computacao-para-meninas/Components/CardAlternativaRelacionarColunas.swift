import SwiftUI

struct CardAlternativaRelacionarColunas: View {
    enum Estado {
        case normal
        case selecionado
        case desativado
        case erro
    }
    
    let estado: Estado
    let alternativa: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill((estado == .desativado ? Color("LightGreen") : Color("LightestGray")))
                .stroke(strokeColor(), lineWidth: (estado == .desativado ? 4 : estado == .selecionado ? 8 : 4))
                .frame(width: 150, height: 130)
            Text(alternativa)
                .foregroundStyle((estado == .desativado ? Color("DarkGreen") : Color.black))
                .frame(width: 120)
                .multilineTextAlignment(.leading)
        }
        .padding()
    }
    
    private func strokeColor() -> Color {
        switch(estado) {
        case .desativado:
            return Color("DarkGreen")
        case .erro:
            return Color("Wrong")
        case .selecionado:
            return Color("AccentColor")
        case .normal:
            return Color("Gray")
        }
    }

}
