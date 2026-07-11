//
//  BarraTempoSpeedrun.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 10/07/26.
//

import SwiftUI

struct BarraTempoSpeedrun: View {
    
    @State var endDate: Date = Date().addingTimeInterval(60)
    @State var certas: Int = 0
    
    var body: some View {
        TimelineView(.animation) { context in
            VStack {
                HStack {
                    Image(systemName: "clock")
                    Text("0:"+String(Int(endDate.timeIntervalSince(context.date))))
                        .font(.title2.bold())
                    Spacer()
                    Image(systemName: "bolt.fill")
                        .foregroundStyle(Color("Text"))
                    Text(String(certas))
                        .font(.title2.bold())
                        .foregroundStyle(Color("Text"))
                }
                .frame(width: 350)
                ZStack (alignment: .leading) {
                    Capsule()
                        .frame(width: 350, height: 20)
                        .foregroundColor(Color("LightGray"))
                    Capsule()
                        .frame(width: 350 * CGFloat(endDate.timeIntervalSince(context.date)/60), height: 20)
                        .foregroundColor(Color("Text"))
                }
            }
        }
        .onAppear {
            endDate = Date().addingTimeInterval(60)
        }
    }
}

#Preview {
    BarraTempoSpeedrun()
}
