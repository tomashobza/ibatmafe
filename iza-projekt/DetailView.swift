//
//  DetailView.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 23.04.2024.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    @Bindable var item: Event

    var body: some View {
        ZStack {
            Color
                .oranzova
                .overlay(
                    Color.black.opacity(0.5)
                )
                .overlay(
                    GrainyTextureView()
                        .opacity(0.25)
                )
                .ignoresSafeArea(.all)

            VStack {
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
                .scrollContentBackground(.hidden)
            }
            .navigationTitle(
                Text("Edit event")
            )
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Event.self, configurations: config)
        let item = Event(title: "cus", subject: "tom")

        return DetailView(item: item)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create ModelContainer: \(error)")
    }
}
