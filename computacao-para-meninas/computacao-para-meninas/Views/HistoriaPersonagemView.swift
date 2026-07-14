import SwiftUI

struct HistoriaPersonagemView: View {
    let personagem: Personagem

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(personagem.nome)
                        .font(.system(.title2, design: .rounded, weight: .bold))
                        .foregroundStyle(Color(.black))

                    Image(personagem.imagem)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .frame(height: 220)

                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(Array(personagem.historia.enumerated()), id: \.offset) { _, paragrafo in
                            Text(paragrafo)
                                .font(.system(.body, design: .rounded))
                                .foregroundStyle(Color(.black))
                        }
                    }
                }
                .padding(20)
                .background(Color("AccentColor").opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color("AccentColor"), lineWidth: 1.5)
                )
                .padding(20)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .safeAreaInset(edge: .top) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(Color("Text"))
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color("Background"))
        }
    }
}

#Preview {
    NavigationStack {
        HistoriaPersonagemView(personagem: HistoriasViewModel().personagens[0])
    }
}
