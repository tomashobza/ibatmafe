//
//  EventTypeBadge.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 20.05.2024.
//

import SwiftUI

struct EventTypeBadge: View {
    let type: EventType
    
    var eventTypeColor: Color {
        switch type {
        case .midterm:
            return .orange
        case .final:
            return .red
        case .general:
            return .gray
        case .project:
            return .blue
        }
    }

    var body: some View {
        Text(type.rawValue.capitalized)
            .font(.caption2)
            .bold()
            .foregroundColor(eventTypeColor)
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(eventTypeColor.opacity(0.2))
            .cornerRadius(100)
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .stroke(eventTypeColor, lineWidth: 1.5)
            )
    }
}

#Preview {
    EventTypeBadge(type: .final)
}
