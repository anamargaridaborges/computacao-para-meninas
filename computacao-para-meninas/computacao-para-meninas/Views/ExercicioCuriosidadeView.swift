import SwiftUI

struct ExercicioCuriosidadeView: View {
    var aoConcluirRodada: () -> Void
    let curiosidade: String
    
    var body: some View {
        VStack {
            Text(curiosidade)
                .font(.system(.title3, design: .rounded))
                .foregroundStyle(.black)
                .padding(.horizontal, 20)
            
            Spacer()
            
            Button(action: {
                aoConcluirRodada()
            }) {
                BotaoContinuar()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

