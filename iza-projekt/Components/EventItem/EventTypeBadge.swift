//
//  EventTypeBadge.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 20.05.2024.
//

import SwiftUI

struct EventTypeBadge: View {
    // A constant holding the type of the event
    let type: EventType

    // Computed property to determine the color based on the event type
    var eventTypeColor: Color {
        switch type {
        case .midterm:
            return .orange // Orange color for midterm events
        case .final:
            return .red // Red color for final events
        case .general:
            return .gray // Gray color for general events
        case .project:
            return .blue // Blue color for project events
        }
    }

    var body: some View {
        // Display the event type text
        Text(type.rawValue.capitalized) // Capitalizes the raw value of the enum case
            .font(.caption2) // Sets the font size to caption2
            .bold() // Makes the font bold
            .foregroundColor(eventTypeColor) // Sets the text color to the event type color
            .padding(.horizontal, 10) // Adds horizontal padding around the text
            .padding(.vertical, 8) // Adds vertical padding around the text
            .background(eventTypeColor.opacity(0.2)) // Sets a background color with reduced opacity
            .cornerRadius(100) // Sets the corner radius to 100, making it fully rounded
            .overlay(
                // Adds a border around the badge with the same event type color
                RoundedRectangle(cornerRadius: 100)
                    .stroke(eventTypeColor, lineWidth: 1.5)
            )
    }
}

// SwiftUI Preview to visualize the EventTypeBadge component in Xcode's canvas
#Preview {
    // Displaying an instance of EventTypeBadge with 'final' type
    EventTypeBadge(type: .final)
}
