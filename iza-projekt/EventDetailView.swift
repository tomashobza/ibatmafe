//
//  DetailView.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 23.04.2024.
//

import SwiftData
import SwiftUI

struct EventDetailView: View {
    @State private var item: Event

    init(item: Event) {
        _item = State(initialValue: item)
    }

    var body: some View {
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
            .scrollContentBackground(
                .hidden
            )
            .background(
                Color.oranzova
                    .overlay(
                        GrainyTextureView()
                            .opacity(0.5)
                            .ignoresSafeArea(.all)
                    )
                    .ignoresSafeArea(edges: .bottom)
            )
        }
        .navigationTitle(
            Text("Edit event")
        )
    }
}

#Preview {
    EventDetailView(item: Event(title: "cus", subject: "tom"))
}
