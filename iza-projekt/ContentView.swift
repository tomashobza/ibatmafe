//
//  ContentView.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 22.04.2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.colorScheme) var colorScheme
    @Query var events: [Event]

    @State private var showingSheet = false // State for showing the sheet
    @State private var navigationPath = NavigationPath() // State for the navigation path
    @State private var selectedEvent: Event? // State for the selected event to edit

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.bila] // TODO: make this be .oranzova in dark mode and .bg in light mode
        // Inline Navigation Title
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.oranzova]
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack(alignment: .top) {
                ScrollView {
                    // Scrollable content
                    VStack(spacing: 20) {
                        ForEach(events, id: \.self) { event in
                            EventItem(item: event, onDelete: {
                                deleteEvent(event)
                            }, onEdit: {
                                navigationPath.append(event)
                            })
                        }
                        Rectangle().frame(height: 30).opacity(0)
                    }
                    .offset(y: 20)
                    .padding(.horizontal)
                }
            }
            .background(
                GrainyTextureView()
                    .opacity(0.5)
                    .ignoresSafeArea(.all)
            )
            .background(colorScheme == .dark ? .bg : .oranzova)
            .edgesIgnoringSafeArea(.bottom)
            .sheet(isPresented: $showingSheet) {
                NewEventDrawer()
            }
            .navigationTitle(
                Text("Events") // TODO: change the fucking color of this title!!
            )
            .navigationDestination(for: Event.self) { event in
                EventDetailView(item: event)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    HStack {
                        Button(action: {
                            showingSheet = true
                        }) {
                            Image(systemName: "plus")
                        }
                        .font(.title2)
                        .foregroundStyle(colorScheme == .dark ? .oranzova : .bg)
                    }
                }
            }
            .toolbarBackground(.clear)
        }
    }

    func deleteEvent(_ event: Event) {
        modelContext.delete(event)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Event.self, configurations: config)

        let sampleEvent = Event(title: "cus", subject: "tom")
        container.mainContext.insert(sampleEvent)

        return ContentView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create ModelContainer: \(error)")
    }
}
