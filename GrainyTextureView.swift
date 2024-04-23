//
//  GrainyTextureView.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 23.04.2024.
//

import SwiftUI

struct GrainyTextureView: View {
    var body: some View {
        Image("grainytexture")
                    .resizable()
                    .scaledToFill()
                    .blendMode(.darken)
                    .opacity(0.5)
    }
}

#Preview {
    GrainyTextureView()
}
