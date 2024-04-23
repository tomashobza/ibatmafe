//
//  GridTextureView.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 23.04.2024.
//

import SwiftUI

struct GridTextureView: View {
    var body: some View {
        Image("gridtexture")
            .resizable()
            .scaledToFill()
//            .ignoresSafeArea()
            .colorInvert()
            .blendMode(.darken)
    }
}

#Preview {
    GridTextureView().background(.bg)
}
