//
//  GrainyTextureView.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 23.04.2024.
//

import SwiftUI

struct GrainyTextureView: View {
    var body: some View {
        // Displays a grainy texture image as a background
        Image("grainytexture") // Loads the image
            .resizable() // Allows the image to be resized
            .scaledToFill() // Ensures the image fills its container
            .blendMode(.overlay) // Sets the blend mode to overlay
            .opacity(0.25) // Reduces the opacity to blend subtly with the background
    }
}

// SwiftUI Preview for visual testing
#Preview {
    GrainyTextureView()
}
