//
//  EventForm.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 20.05.2024.
//

import SwiftUI

struct EventForm: View {
    @Binding var item: Event // Enables two-way binding for event data
    @Environment(\.modelContext) var modelContext // Provides access to the data model context

    var body: some View {
        Section(header: Text("Event Details")) {
            // Text field for the event's title
            TextField("Title", text: $item.title)
            // Text field for the event's subject
            TextField("Subject", text: $item.subject)
            // Date picker for selecting the event date
            DatePicker("Date", selection: $item.date, displayedComponents: .date)
        }

        Section(header: Text("Type")) {
            // Picker for selecting the event type
            Picker("Type", selection: $item.type) {
                // Options generated for all event types
                ForEach(EventType.allCases, id: \.self) { type in
                    Text(type.rawValue.capitalized).tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle()) // Style for the picker
        }
    }
}
