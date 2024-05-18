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
    @State private var searchText = "" // State for search text
    @State private var showSearchBar = false // State to show/hide search bar

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UITraitCollection.current.userInterfaceStyle == .dark ? UIColor.oranzova : UIColor.bg, .font: UIFont(name: "Lora", size: 34)!]
        // Inline Navigation Title
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UITraitCollection.current.userInterfaceStyle == .dark ? UIColor.oranzova : UIColor.bg]

        // Set the tint color of the UITextField within the UISearchBar
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UITraitCollection.current.userInterfaceStyle == .dark ? UIColor.oranzova : UIColor.bg

        // Customize the color of the search bar "Cancel" button
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UITraitCollection.current.userInterfaceStyle == .dark ? UIColor.oranzova : UIColor.bg
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack(alignment: .top) {
                ScrollView {
                    // Scrollable content
                    VStack(spacing: 20) {
                        ForEach(filteredEvents, id: \.self) { event in
                            EventItem(item: event, onDelete: {
                                deleteEvent(event)
                            }, onEdit: {
                                navigationPath.append(event)
                            })
                        }
                        Rectangle().frame(height: 30).opacity(0)
                    }
                    .padding(.horizontal)
                    .gesture(DragGesture().onChanged { value in
                        if value.translation.height < -20 {
                            withAnimation {
                                showSearchBar = true
                            }
                        }
                    })
                    .searchable(text: $searchText) // Conditionally display the search bar
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
                Text("Events")
                    .foregroundColor(colorScheme == .dark ? Color.oranzova : Color.bg) // Update title color based on color scheme
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
        }
    }

    var filteredEvents: [Event] {
        if searchText.isEmpty {
            return events
        } else {
            return events.filter { $0.title.lowercased().contains(searchText.lowercased()) || $0.subject.lowercased().contains(searchText.lowercased()) }
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
