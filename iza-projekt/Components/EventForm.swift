//
//  EventForm.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 20.05.2024.
//

import SwiftData
import SwiftUI

struct EventForm: View {
    @Binding var item: Event // Enables two-way binding for event data
    @Environment(\.modelContext) var modelContext // Provides access to the data model context

    @Query var events: [Event] // Fetches all events from the data model

    @State private var showTitleSuggestions = false // Indicates whether to show title suggestions
    @State private var showSubjectSuggestions = false // Indicates whether to show subject suggestions

    var body: some View {
        Section(header: Text("Event Details")) {
            // Text field for the event's title
            TextField("Title", text: $item.title, onEditingChanged: { editingChanged in
                showTitleSuggestions = editingChanged
            })
            // Suggestions for the event title
            if showTitleSuggestions && !item.title.isEmpty {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(events.map { $0.title }.filter { $0.lowercased().contains(item.title.lowercased()) }, id: \.self) { suggestion in
                            Button(action: {
                                item.title = suggestion
                            }) {
                                Text(suggestion)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
            // Text field for the event's subject
            TextField("Subject", text: $item.subject, onEditingChanged: { editingChanged in
                showSubjectSuggestions = editingChanged
            })
            // Suggestions for the event subject
            if showSubjectSuggestions && !item.subject.isEmpty {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(events.map { $0.subject }.filter { $0.lowercased().contains(item.subject.lowercased()) }, id: \.self) { suggestion in
                            Button(action: {
                                item.subject = suggestion
                            }) {
                                Text(suggestion)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
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
