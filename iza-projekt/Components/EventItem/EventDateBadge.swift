//
//  EventDateBadge.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 20.05.2024.
//

import SwiftUI

struct EventDateBadge: View {
    // Property to hold the date to be displayed
    var date: Date

    var body: some View {
        // Display the date formatted as numeric date and shortened time
        Text(date.formatted(date: .numeric, time: .shortened))
            .font(.caption2) // Sets the font size to a smaller, secondary text style
            .bold() // Makes the text bold
            .foregroundColor(.bg) // Sets the text color, using 'bg' defined in the environment or elsewhere
            .padding(.horizontal, 10) // Horizontal padding to extend the text's background
            .padding(.vertical, 8) // Vertical padding to increase the height of the text's background
            .cornerRadius(100) // Applies a corner radius to make the background fully rounded
            .overlay(
                // Adds a border around the text with a specific color and line width
                RoundedRectangle(cornerRadius: 100)
                    .stroke(.bg, lineWidth: 1.5)
            )
    }
}

// SwiftUI Preview to visualize the EventDateBadge component in Xcode's canvas
#Preview {
    // Displaying an instance of the EventDateBadge with the current date
    EventDateBadge(date: Date())
}
