//
//  DashboardItem.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 22.04.2024.
//

import SwiftData
import SwiftUI

struct EventItem: View {
    var item: Event
    @Environment(\.colorScheme) var colorScheme

    var onDelete: () -> Void // Closure to handle deletion
    var onEdit: () -> Void // Closure to handle editing

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                EventTypeBadge(type: item.type)

                Spacer()

                EventDateBadge(date: item.date)
            }

            EventDetails(title: item.title, subject: item.subject)

            // Adding the progress bar if there are tasks
            if item.tasks.count > 0 {
                EventProgressBar(tasks: item.tasks)
            }
        }
        .padding()
        .background(colorScheme == .dark ? Color.white : Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .foregroundColor(.bg)
        .onTapGesture {
            onEdit()
        }
        .contextMenu {
            Button(action: {
                // Action for editing the event
                onEdit()
            }) {
                Label("Edit", systemImage: "pencil")
            }

            Button(action: {
                // Action for deleting the event
                onDelete()
            }) {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Event.self, configurations: config)
        let item = Event(title: "cus", subject: "tom")

        return EventItem(item: item, onDelete: {}, onEdit: {})
            .modelContainer(container)
    } catch {
        fatalError("Failed to create ModelContainer: \(error)")
    }
}
