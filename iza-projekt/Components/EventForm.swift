//
//  EventForm.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 20.05.2024.
//

import SwiftUI

struct EventForm: View {
    @Binding var item: Event // Use a binding to allow two-way data flow
    @Environment(\.modelContext) var modelContext // Access the model context if needed

    var body: some View {
        Section(header: Text("Event Details")) {
            TextField("Title", text: $item.title)
            TextField("Subject", text: $item.subject)
            DatePicker("Date", selection: $item.date, displayedComponents: .date)
        }

        Section(header: Text("Type")) {
            Picker("Type", selection: $item.type) {
                ForEach(EventType.allCases, id: \.self) { type in
                    Text(type.rawValue.capitalized).tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}
