//
//  DashboardItem.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 22.04.2024.
//

import SwiftData
import SwiftUI

struct EventItem: View {
    // Event data passed to the view
    var item: Event
    // Access the current color scheme from the environment
    @Environment(\.colorScheme) var colorScheme

    // Callbacks for handling user interactions
    var onDelete: () -> Void // Closure to handle deletion
    var onEdit: () -> Void // Closure to handle editing

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // Display a badge with the event type
                EventTypeBadge(type: item.type)

                Spacer() // Spacer to push the content to the edges

                // Display a badge with the formatted date of the event
                EventDateBadge(date: item.date)
            }

            // Display the title and subject of the event
            EventDetails(title: item.title, subject: item.subject)

            // Conditional display of progress bar if there are tasks
            if item.tasks.count > 0 {
                EventProgressBar(tasks: item.tasks)
            }
        }
        .padding() // Padding around the VStack content
        .background(colorScheme == .dark ? Color.white : Color.white) // Background color based on color scheme
        .clipShape(RoundedRectangle(cornerRadius: 20)) // Rounded corners for the VStack background
        .foregroundColor(.bg) // Foreground color
        .onTapGesture {
            onEdit() // Handle tap gesture to edit the event
        }
        .contextMenu { // Context menu for additional options
            Button(action: {
                onEdit() // Action to edit the event
            }) {
                Label("Edit", systemImage: "pencil") // Edit button with pencil icon
            }

            Button(action: {
                onDelete() // Action to delete the event
            }) {
                Label("Delete", systemImage: "trash") // Delete button with trash icon
            }
        }
    }
}

// Preview block for visualizing the component in Xcode's canvas
#Preview {
    do {
        // Setup a temporary in-memory database configuration for testing
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Event.self, configurations: config)
        let item = Event(title: "cus", subject: "tom")

        // Return the EventItem view using a model container
        return EventItem(item: item, onDelete: {}, onEdit: {})
            .modelContainer(container)
    } catch {
        fatalError("Failed to create ModelContainer: \(error)") // Error handling if the model container fails
    }
}
