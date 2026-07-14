import SwiftUI

struct ResultadoSpeedrunView: View {

    let certas: Int
    let aoJogarDeNovo: () -> Void
    let aoSair: () -> Void
    @AppStorage("recorde") var recorde: Int = 0

    var body: some View {
        ZStack {

            VStack(spacing: 24) {
                Spacer()

                Text("Tempo esgotado!")
                    .font(.largeTitle.bold())
                    .foregroundStyle(Color("Text"))

                HStack(spacing: 8) {
                    Image(systemName: "bolt.fill")
                        .foregroundStyle(Color("Text"))
                    Text("\(certas)")
                        .font(.system(size: 72, weight: .bold))
                        .foregroundStyle(Color("Text"))
                }
                .foregroundStyle(Color.white)

                Text(certas == 1 ? "questão resolvida" : "questões resolvidas")
                    .font(.title3)
                    .foregroundStyle(Color("Text"))

                Spacer()

                Button(action: aoJogarDeNovo) {
                    BotaoContinuar(texto: "Jogar de novo")
                }

                Button(action: aoSair) {
                    Text("Sair")
                        .foregroundStyle(Color("Text"))
                        .bold()
                }
                .padding(.bottom, 24)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            recorde = max(recorde, certas)
        }
    }
}

#Preview {
    ResultadoSpeedrunView(certas: 7, aoJogarDeNovo: {}, aoSair: {})
}
