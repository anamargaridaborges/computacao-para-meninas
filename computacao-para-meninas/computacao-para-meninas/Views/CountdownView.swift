import SwiftUI

struct CountdownView: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Binding var tempoRestante: Int
    
    var body: some View {
        ZStack {
            Color("Color2Button").ignoresSafeArea(edges: .all)
            Text(tempoRestante > 1 ? String(tempoRestante-1) : "Já!")
                .font(.system(size: 144))
                .foregroundStyle(Color.white)
        }
        .onReceive(timer) { _ in
            tempoRestante -= 1
        }
        .navigationBarBackButtonHidden(true)
    }
}
