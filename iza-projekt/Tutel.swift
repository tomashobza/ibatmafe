//
//  Tutel.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 22.04.2024.
//

import SwiftUI

struct Tutel: View {
    var body: some View {
        Image("tutel")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay {
                Rectangle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
            .padding()
    }
}

#Preview {
    Tutel()
}
