//
//  ContentView.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 22.04.2024.
//

import SwiftData
import SwiftUI

enum GroupingOption: String, CaseIterable {
    case none = "Don't group"
    case subject = "Group by subject"
}

enum SortingOption: String, CaseIterable {
    case date = "Order by date"
    case name = "Order by name"
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.colorScheme) var colorScheme
    @Query var events: [Event]

    @State private var showingSheet = false // State for showing the sheet
    @State private var navigationPath = NavigationPath() // State for the navigation path
    @State private var selectedEvent: Event? // State for the selected event to edit
    @State private var searchText = "" // State for search text
    @State private var showOptions = false // State to show/hide options
    @State private var groupingOption: GroupingOption = .none // State for grouping option
    @State private var sortingOption: SortingOption = .date // State for sorting option

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UITraitCollection.current.userInterfaceStyle == .dark ? UIColor.oranzova : UIColor.bg,
            .font: UIFont(name: "Lora", size: 34)!
        ]

        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UITraitCollection.current.userInterfaceStyle == .dark ? UIColor.oranzova : UIColor.bg
        ]

        // Set the tint color of the UITextField within the UISearchBar
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UITraitCollection.current.userInterfaceStyle == .dark ? UIColor.oranzova : UIColor.bg

        // Attempt to specifically customize the color of the search bar "Cancel" button
        let barButtonItemAppearanceInSearchBar = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        barButtonItemAppearanceInSearchBar.tintColor = UITraitCollection.current.userInterfaceStyle == .dark ? UIColor.oranzova : UIColor.bg
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack(alignment: .top) {
                ScrollView {
                    // Scrollable content
                    VStack(spacing: 20) {
                        // Grouping and Ordering Pickers
                        if showOptions { // Show the grouping options only when "showOptions" is true
                            VStack {
                                Picker("Grouping", selection: $groupingOption) {
                                    ForEach(GroupingOption.allCases, id: \.self) { option in
                                        Text(option.rawValue).tag(option)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())

                                Picker("Sorting", selection: $sortingOption) {
                                    ForEach(SortingOption.allCases, id: \.self) { option in
                                        Text(option.rawValue).tag(option)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                        }

                        // Display Events
                        if groupingOption == .subject {
                            ForEach(groupedEventsBySubject.keys.sorted(), id: \.self) { subject in
                                VStack(alignment: .leading) {
                                    Text(subject).font(.headline) // Show subject title
                                    ForEach(groupedEventsBySubject[subject]!, id: \.self) { event in
                                        EventItem(item: event, onDelete: {
                                            deleteEvent(event)
                                        }, onEdit: {
                                            navigationPath.append(event)
                                        })
                                    }
                                }
                            }
                        } else {
                            ForEach(groupedAndSortedEvents, id: \.self) { event in
                                EventItem(item: event, onDelete: {
                                    deleteEvent(event)
                                }, onEdit: {
                                    navigationPath.append(event)
                                })
                            }
                        }

                        Rectangle().frame(height: 30).opacity(0)
                    }
                    .padding(.horizontal)
                    .searchable(text: $searchText) // Conditionally display the search bar
                    .onAppear {
                        UISearchBar.appearance().tintColor = colorScheme == .dark ? UIColor.oranzova : UIColor.bg
                    }
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
            .navigationTitle("Events")
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

                        Button(action: {
                            withAnimation {
                                showOptions.toggle()
                            }
                        }) {
                            Image(systemName: "slider.horizontal.3")
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

    var groupedAndSortedEvents: [Event] {
        let groupedEvents: [Event]

        switch groupingOption {
        case .none:
            groupedEvents = filteredEvents
        case .subject:
            groupedEvents = filteredEvents.sorted(by: { $0.subject < $1.subject })
        }

        switch sortingOption {
        case .date:
            return groupedEvents.sorted(by: { $0.date < $1.date })
        case .name:
            return groupedEvents.sorted(by: { $0.title < $1.title })
        }
    }

    var groupedEventsBySubject: [String: [Event]] {
        var grouped = Dictionary(grouping: filteredEvents, by: { $0.subject })
        for (key, value) in grouped {
            grouped[key] = value.sorted {
                switch sortingOption {
                case .date:
                    return $0.date < $1.date
                case .name:
                    return $0.title < $1.title
                }
            }
        }
        return grouped
    }

    func deleteEvent(_ event: Event) {
        modelContext.delete(event)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Event.self, configurations: config)

        let sampleEvent = Event(title: "cus", subject: "tom", date: Date())
        container.mainContext.insert(sampleEvent)
        
        let tasks = [Task(text: "Task 1", isDone: true), Task(text: "Task 2", isDone: false)]
        let item = Event(title: "Meeting", subject: "Discuss project", type: .project, tasks: tasks)
        container.mainContext.insert(item)


        return ContentView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create ModelContainer: \(error)")
    }
}
