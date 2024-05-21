//
//  ContentView.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 22.04.2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    // Environmental variables for data management and UI themes
    @Environment(\.modelContext) var modelContext
    @Environment(\.colorScheme) var colorScheme

    // State variables to handle data and UI behavior
    @Query var events: [Event]
    @State private var showingSheet = false
    @State private var navigationPath = NavigationPath()
    @State private var searchText = ""
    @State private var showOptions = false
    @State private var groupingOption: GroupingOption = .none
    @State private var sortingOption: SortingOption = .date
    @State private var sortingDirection: SortingDirection = .ascending

    init() {
        // Configure navigation bar appearance globally
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UITraitCollection.current.userInterfaceStyle == .dark ? UIColor.oranzova : UIColor.bg,
            .font: UIFont(name: "Lora", size: 34)!
        ]
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UITraitCollection.current.userInterfaceStyle == .dark ? UIColor.oranzova : UIColor.bg
        ]
        // Configure specific UI elements within the UISearchBar
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UITraitCollection.current.userInterfaceStyle == .dark ? UIColor.oranzova : UIColor.bg
        let barButtonItemAppearanceInSearchBar = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        barButtonItemAppearanceInSearchBar.tintColor = UITraitCollection.current.userInterfaceStyle == .dark ? UIColor.oranzova : UIColor.bg
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack(alignment: .top) {
                ScrollView {
                    VStack(spacing: 20) {
                        // Conditional display of options for sorting and grouping
                        if showOptions {
                            EventDashboardOptions(groupingOption: $groupingOption, sortingOption: $sortingOption, sortingDirection: $sortingDirection)
                        }
                        // Event list view component
                        EventDashboard(events: filteredAndSortedEvents(), groupingOption: groupingOption, deleteEvent: deleteEvent, editEvent: { event in
                            navigationPath.append(event)
                        })
                    }
                    .padding(.horizontal)
                    .searchable(text: $searchText) // Search bar integration
                }
            }
            .frame(maxWidth: .infinity)
            .background(GrainyTextureView().opacity(0.5).ignoresSafeArea(.all))
            .background(colorScheme == .dark ? .bg : .oranzova)
            .sheet(isPresented: $showingSheet) {
                NewEventDrawer()
            }
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    actionButtons
                }
            }
            .navigationDestination(for: Event.self) { event in
                EventDetailView(item: event)
            }
        }
    }

    // Action buttons for adding new events and toggling options
    private var actionButtons: some View {
        HStack {
            Button(action: { showingSheet = true }) {
                Image(systemName: "plus")
            }
            .foregroundStyle(colorScheme == .dark ? .oranzova : .bg)

            Button(action: { withAnimation { showOptions.toggle() } }) {
                Image(systemName: "slider.horizontal.3")
            }
            .foregroundStyle(colorScheme == .dark ? .oranzova : .bg)
        }
    }

    // Filtering and sorting logic for events
    private func filteredAndSortedEvents() -> [Event] {
        let filteredEvents = events.filter { event in
            searchText.isEmpty ||
                event.title.lowercased().contains(searchText.lowercased()) ||
                event.subject.lowercased().contains(searchText.lowercased())
        }
        let sortedEvents = filteredEvents.sorted { first, second in
            let isAscending = sortingDirection == .ascending
            switch sortingOption {
            case .date:
                return isAscending ? first.date < second.date : first.date > second.date
            case .name:
                return isAscending ? first.title.lowercased() < second.title.lowercased() : first.title.lowercased() > second.title.lowercased()
            }
        }
        return sortedEvents
    }

    // Function to handle event deletion
    private func deleteEvent(_ event: Event) {
        modelContext.delete(event)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Event.self, configurations: config)

        let sampleEvent = Event(title: "cus", subject: "tom", date: Date())

        let tasks = [Task(text: "Task 1", isDone: true), Task(text: "Task 2", isDone: false)]
        let item = Event(title: "Meeting", subject: "Discuss project", type: .project, tasks: tasks)

        container.mainContext.insert(sampleEvent)
        container.mainContext.insert(item)

        return ContentView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create ModelContainer: \(error)")
    }
}
