//
//  DashboardItem.swift
//  Landmarks
//
//  Created by Tomáš Hobza on 22.04.2024.
//

import SwiftUI

struct DashboardItem: View {
    var color: Color
    var text: String
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: 100)
            .cornerRadius(20)
            .overlay(
                Text(text)
                    .font(.title)
                    .foregroundColor(.white)
            )
    }
}

#Preview {
    DashboardItem(color:Color.pink, text:"ahoj")
}
