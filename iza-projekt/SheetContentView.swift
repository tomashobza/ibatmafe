//
//  SheetContentView.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 23.04.2024.
//

import SwiftUI

struct SheetContentView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Here's some information for you.")
                .padding()

            Button("Close") {
                // Dismiss the sheet
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
        }
        .padding()
    }
}

#Preview {
    SheetContentView()
}
