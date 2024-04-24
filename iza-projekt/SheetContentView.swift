//
//  SheetContentView.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 23.04.2024.
//

import SwiftData
import SwiftUI

struct SheetContentView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode

    @Bindable var item: Event = .init(title: "", subject: "")

    var body: some View {
        VStack {
//            Button("Cus")
            Text("Create event")
                .font(.title)
                .padding()

            Form {
                TextField("Title", text: $item.title)
                TextField("Subject", text: $item.subject)
                DatePicker("Date", selection: $item.date)

                Section("Type") {
                    Picker("Type", selection: $item.type) {
                        Text("General").tag(EventType.general)
                        Text("Project").tag(EventType.project)
                        Text("Final").tag(EventType.final)
                        Text("Midterm").tag(EventType.midterm)
                    }
                }
            }
            VStack {
                HStack {
                    Button("Dismiss") {
                        // Dismiss the sheet
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                    .foregroundColor(.bg)
                    .background(Color.gray)
                    .cornerRadius(10)

                    Button("Save") {
                        // Save the event
                        modelContext.insert(item)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                    .foregroundColor(.bg)
                    .background(Color.oranzova)
                    .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}

#Preview {
    SheetContentView()
}
