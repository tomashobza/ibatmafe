//
//  VisualEffectBlur.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 15.05.2024.
//

import SwiftUI
import UIKit

struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: blurStyle)
    }
}

#Preview {
    VisualEffectBlur(blurStyle: .systemMaterial)
}
