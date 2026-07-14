import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            TrilhaView()
                .tabItem {
                    Label("Trilhas", systemImage: "map.fill")
                }
                .accessibilityIdentifier("tab_trilhas")

            CardsHistoriasView()
                .tabItem {
                    Label("Histórias", systemImage: "book.fill")
                }
                .accessibilityIdentifier("tab_historias")
        }
        .tint(Color("Text"))
    }
}

#Preview {
    RootTabView()
}
