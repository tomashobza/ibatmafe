//
//  EventDashboard.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 20.05.2024.
//

import SwiftUI

struct EventDashboard: View {
    var events: [Event]
    var groupingOption: GroupingOption
    var deleteEvent: (Event) -> Void
    var editEvent: (Event) -> Void

    var body: some View {
        Group {
            if groupingOption == .subject {
                // Logic to display events grouped by subject
                ForEach(groupedEventsBySubject(events).keys.sorted(), id: \.self) { subject in
                    VStack(alignment: .leading) {
                        Text(subject).font(.headline)
                        ForEach(groupedEventsBySubject(events)[subject]!, id: \.self) { event in
                            EventItem(item: event, onDelete: { deleteEvent(event) }, onEdit: { editEvent(event) })
                        }
                    }
                }
            } else {
                // Logic to display events in a single list
                ForEach(events, id: \.self) { event in
                    EventItem(item: event, onDelete: { deleteEvent(event) }, onEdit: { editEvent(event) })
                }
            }
        }
    }

    // Helper function to group events by subject
    private func groupedEventsBySubject(_ events: [Event]) -> [String: [Event]] {
        Dictionary(grouping: events, by: { $0.subject })
    }
}
