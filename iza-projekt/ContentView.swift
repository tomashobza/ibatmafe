//
//  ContentView.swift
//  Landmarks
//
//  Created by Tomáš Hobza on 22.04.2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var events: [Event]

    @State private var showingSheet = false // State for showing the sheet

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Title
                HStack {
                    Text("Your dashboard")
                        .font(.custom("Lora", size: 32, relativeTo: .body))
                        .padding()
                        .foregroundStyle(.bg)

                    Spacer()
                    Button(action: {
                        showingSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .foregroundStyle(.bg)
                    .font(.title)
                }
                .overlay(
                    GrainyTextureView()
                        .opacity(0.5)
                )
                .background(Color.oranzova)

//                Tutel()

                ScrollView {
                    // Scrollable content
                    VStack(spacing: 20) {
                        ForEach(events, id: \.self) { event in
                            NavigationLink(destination: DetailView(item: event)) {
                                DashboardItem(item: event)
                            }
                        }
                        Rectangle().frame(height: 30).opacity(0)
                    }.offset(y: 20)
                        .padding(.horizontal)
                }
            }
            .background(.bg)
            .edgesIgnoringSafeArea(.bottom)
            .sheet(isPresented: $showingSheet) {
                SheetContentView()
            }
        }
    }

    func addSamples() {
        let event = Event(subject: "Test event", date: Date())
        modelContext.insert(event)
    }

    func deleteEvents(_ indexSet: IndexSet) {
        for index in indexSet {
            let event = events[index]
            modelContext.delete(event)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Event.self, configurations: config)
        let item = Event(title: "cus", subject: "tom")

        return ContentView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create ModelContainer: \(error)")
    }
}
