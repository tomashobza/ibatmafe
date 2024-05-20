//
//  EventDetails.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 20.05.2024.
//

import SwiftUI

struct EventDetails: View {
    // Properties to hold the title and subject of the event
    var title: String
    var subject: String

    var body: some View {
        // Vertical stack to layout the title and subject text views
        VStack(alignment: .leading, spacing: 5) {
            // Display the title of the event
            Text(title)
                .font(.title2) // Sets the font size and weight to title2
                .foregroundColor(.bg) // Sets the foreground color using the environment's bg color
            // Display the subject of the event
            Text(subject)
                .font(.subheadline) // Sets the font size and weight to subheadline
                .foregroundColor(.bg) // Sets the foreground color using the environment's bg color
        }
    }
}

// SwiftUI Preview for the EventDetails view
#Preview {
    // Providing example data for previewing the component in Xcode
    EventDetails(title: "test", subject: "ABC")
}
