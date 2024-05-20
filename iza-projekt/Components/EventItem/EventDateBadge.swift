//
//  EventDateBadge.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 20.05.2024.
//

import SwiftUI

struct EventDateBadge: View {
    var date: Date
    var body: some View {
        Text(date.formatted(date: .numeric, time: .shortened))
            .font(.caption2)
            .bold()
            .foregroundColor(.bg)
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .cornerRadius(100)
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .stroke(.bg, lineWidth: 1.5)
            )
    }
}

#Preview {
    EventDateBadge(date: Date())
}
