//
//  DashboardItem.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 22.04.2024.
//

import SwiftData
import SwiftUI

struct DashboardItem: View {
    var item: Event

    var body: some View {
//        Rectangle()
//            .fill(.white)
//            .frame(height: 100)
//            .cornerRadius(20)
//            .overlay(
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(item.title)
                    .font(.title2)
                Spacer()
                Text(item.date.formatted(date: .numeric, time: .shortened))
                    .font(.caption2)
                    .foregroundStyle(.bg)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .cornerRadius(100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(.bg, lineWidth: 1)
                    )
            }
            Text(item.subject)
                .font(.subheadline)
        }
        .padding()
        .background(.bila)
        .clipShape(.rect(cornerRadius: 20))
        .foregroundStyle(.bg)
//            )
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Event.self, configurations: config)
        let item = Event(title: "cus", subject: "tom")

        return DashboardItem(item: item)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create ModelContainer: \(error)")
    }
}
