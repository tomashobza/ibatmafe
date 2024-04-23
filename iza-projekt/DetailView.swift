//
//  DetailView.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 23.04.2024.
//

import SwiftUI

struct DetailView: View {
    var item: String

    var body: some View {
        ZStack {
            Color.bg.ignoresSafeArea(.all)
            
            VStack {
                Text("Details for \(item)")
                    .font(.title)
                Text("Here are more details about \(item).")
                    .padding()
            }
            .navigationTitle(
                Text("\(item)")
            )
        }
    }
}

#Preview {
    DetailView(item: "cus")
}
