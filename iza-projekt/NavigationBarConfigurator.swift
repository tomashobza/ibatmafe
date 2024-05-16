//
//  NavigationBarConfigurator.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 16.05.2024.
//

import SwiftUI

struct NavigationBarConfigurator: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    func setupColor() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()

        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: colorScheme == .dark ? UIColor.purple : .yellow]
        // Inline Navigation Title
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: colorScheme == .dark ? UIColor.purple : .yellow]

//                if colorScheme == .dark {
//                    appearance.backgroundColor = .black // Assuming .bg is similar to black
//                    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "oranzova") ?? .white]
//                    appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "oranzova") ?? .oranzova]
//                } else {
//                    appearance.backgroundColor = .white // Assuming .bg is similar to white
//                    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "bg") ?? .black]
//                    appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "bg") ?? .black]
//                }
//
//                UINavigationBar.appearance().standardAppearance = appearance
//                UINavigationBar.appearance().compactAppearance = appearance
//                UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    func body(content: Content) -> some View {
        content
            .onAppear(perform: setupColor)
        
        
    }
}
