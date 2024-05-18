//
//  CustomSearchBar.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 18.05.2024.
//

import SwiftUI
import UIKit

struct CustomSearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = ""
            text = ""
            searchBar.resignFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.tintColor = UITraitCollection.current.userInterfaceStyle == .dark ? UIColor.oranzova : UIColor.bg
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}
