import SwiftUI

struct BotaoContinuar: View {
    
    let continuarDesativado: Bool
    let texto: String
    
    init(continuarDesativado: Bool=false, texto: String="Continuar") {
        self.continuarDesativado = continuarDesativado
        self.texto = texto
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill((continuarDesativado ? Color("Gray") : Color("AccentColor")))
                .frame(width: 350, height: 50)
            Text(texto)
                .foregroundStyle(Color.white)
                .bold()
        }
        .accessibilityIdentifier(texto)
    }
}
