//
//  CardModoSpeedrun.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 10/07/26.
//

import SwiftUI

struct CardModoSpeedrun: View {

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("Color2Button"))
                .stroke(Color("Text"))
                .frame(width: 350, height: 300)
            VStack {
                Text("Modo Speedrun")
                    .foregroundStyle(Color.white)
                    .font(.title2.bold())
                    .padding(2)
                Text("Resolva o máximo de questões em 60 segundos!")
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(2)
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .opacity(0.3)
                        .frame(width: 300, height: 50)
                    HStack {
                        Image(systemName: "trophy")
                            .foregroundStyle(Color.white)
                        Text("Seu recorde")
                            .font(.subheadline.bold())
                            .foregroundStyle(Color.white)
                        Spacer()
                        Text("0 questões")
                            .font(.subheadline.bold())
                            .foregroundStyle(Color.white)
                    }
                    .frame(width: 270, height: 50)
                }
                .padding(4)
                NavigationLink(destination: ModoSpeedrunView()) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .stroke(Color("Text"))
                            .frame(width: 300, height: 70)
                        HStack {
                            Text("Começar")
                                .foregroundStyle(Color("Text"))
                                .font(.title2.bold())
                            Image(systemName: "bolt.fill")
                                .foregroundStyle(Color("Text"))
                        }
                    }
                }
                .padding(5)
            }
            .frame(width: 330, height: 300)
        }
        .padding()
    }

}

#Preview {
    CardModoSpeedrun()
}
