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
                Text(item.type.rawValue.capitalized)
                    .font(.caption2)
                    .bold()
                    .foregroundColor(.pink)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .cornerRadius(100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(.pink, lineWidth: 1.5)
                    )
                
                Spacer()
                
                Text(item.date.formatted(date: .numeric, time: .shortened))
                    .font(.caption2)
                    .bold()
                    .foregroundColor(.bg)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .cornerRadius(100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(.bg, lineWidth: 1.5)
                    )
            }
            
            Text(item.title)
                .font(.title2)
                .foregroundColor(.bg)
            Spacer()
            
            Text(item.subject)
                .font(.subheadline)
                .foregroundColor(.bg)
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
