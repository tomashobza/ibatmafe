//
//  EventForm.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 20.05.2024.
//

import SwiftData
import SwiftUI

struct EventForm: View {
    @Binding var item: Event // Enables two-way binding for event data
    @Environment(\.modelContext) var modelContext // Provides access to the data model context

    @Query var events: [Event] // Fetches all events from the data model

    @State private var showTitleSuggestions = false // Indicates whether to show title suggestions
    @State private var showSubjectSuggestions = false // Indicates whether to show subject suggestions

    var body: some View {
        Section(header: Text("Event Details")) {
            // Text field for the event's title
            TextField("Title", text: $item.title, onEditingChanged: { editingChanged in
                showTitleSuggestions = editingChanged
            })
            // Suggestions for the event title
            if showTitleSuggestions && !item.title.isEmpty {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(events.map { $0.title }.filter { $0.lowercased().contains(item.title.lowercased()) }, id: \.self) { suggestion in
                            Button(action: {
                                item.title = suggestion
                            }) {
                                Text(suggestion)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
            // Text field for the event's subject
            TextField("Subject", text: $item.subject, onEditingChanged: { editingChanged in
                showSubjectSuggestions = editingChanged
            })
            // Suggestions for the event subject
            if showSubjectSuggestions && !item.subject.isEmpty {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(events.map { $0.subject }.filter { $0.lowercased().contains(item.subject.lowercased()) }, id: \.self) { suggestion in
                            Button(action: {
                                item.subject = suggestion
                            }) {
                                Text(suggestion)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
            // Date picker for selecting the event date
            DatePicker("Date", selection: $item.date, displayedComponents: .date)
        }

        Section(header: Text("Type")) {
            // Picker for selecting the event type
            Picker("Type", selection: $item.type) {
                // Options generated for all event types
                ForEach(EventType.allCases, id: \.self) { type in
                    Text(type.rawValue.capitalized).tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle()) // Style for the picker
        }
    }
}

//
//  EventDateBadge.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 20.05.2024.
//

import SwiftUI

struct EventDateBadge: View {
    // Property to hold the date to be displayed
    var date: Date

    var body: some View {
        // Display the date formatted as numeric date and shortened time
        Text(date.formatted(date: .numeric, time: .shortened))
            .font(.caption2) // Sets the font size to a smaller, secondary text style
            .bold() // Makes the text bold
            .foregroundColor(.bg) // Sets the text color, using 'bg' defined in the environment or elsewhere
            .padding(.horizontal, 10) // Horizontal padding to extend the text's background
            .padding(.vertical, 8) // Vertical padding to increase the height of the text's background
            .cornerRadius(100) // Applies a corner radius to make the background fully rounded
            .overlay(
                // Adds a border around the text with a specific color and line width
                RoundedRectangle(cornerRadius: 100)
                    .stroke(.bg, lineWidth: 1.5)
            )
    }
}

// SwiftUI Preview to visualize the EventDateBadge component in Xcode's canvas
#Preview {
    // Displaying an instance of the EventDateBadge with the current date
    EventDateBadge(date: Date())
}

//
//  EventDetails.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 20.05.2024.
//

import SwiftUI

struct EventDetails: View {
    // Properties to hold the title and subject of the event
    var title: String
    var subject: String

    var body: some View {
        // Vertical stack to layout the title and subject text views
        VStack(alignment: .leading, spacing: 5) {
            // Display the title of the event
            Text(title)
                .font(.title2) // Sets the font size and weight to title2
                .foregroundColor(.bg) // Sets the foreground color using the environment's bg color
            // Display the subject of the event
            Text(subject)
                .font(.subheadline) // Sets the font size and weight to subheadline
                .foregroundColor(.bg) // Sets the foreground color using the environment's bg color
        }
    }
}

// SwiftUI Preview for the EventDetails view
#Preview {
    // Providing example data for previewing the component in Xcode
    EventDetails(title: "test", subject: "ABC")
}

//
//  DashboardItem.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 22.04.2024.
//

import SwiftData
import SwiftUI

struct EventItem: View {
    // Event data passed to the view
    var item: Event
    // Access the current color scheme from the environment
    @Environment(\.colorScheme) var colorScheme

    // Callbacks for handling user interactions
    var onDelete: () -> Void // Closure to handle deletion
    var onEdit: () -> Void // Closure to handle editing

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // Display a badge with the event type
                EventTypeBadge(type: item.type)

                Spacer() // Spacer to push the content to the edges

                // Display a badge with the formatted date of the event
                EventDateBadge(date: item.date)
            }

            // Display the title and subject of the event
            EventDetails(title: item.title, subject: item.subject)

            // Conditional display of progress bar if there are tasks
            if item.tasks.count > 0 {
                EventProgressBar(tasks: item.tasks)
            }
        }
        .padding() // Padding around the VStack content
        .background(colorScheme == .dark ? Color.white : Color.white) // Background color based on color scheme
        .clipShape(RoundedRectangle(cornerRadius: 20)) // Rounded corners for the VStack background
        .foregroundColor(.bg) // Foreground color
        .onTapGesture {
            onEdit() // Handle tap gesture to edit the event
        }
        .contextMenu { // Context menu for additional options
            Button(action: {
                onEdit() // Action to edit the event
            }) {
                Label("Edit", systemImage: "pencil") // Edit button with pencil icon
            }

            Button(action: {
                onDelete() // Action to delete the event
            }) {
                Label("Delete", systemImage: "trash") // Delete button with trash icon
            }
        }
    }
}

// Preview block for visualizing the component in Xcode's canvas
#Preview {
    do {
        // Setup a temporary in-memory database configuration for testing
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Event.self, configurations: config)
        let item = Event(title: "cus", subject: "tom")

        // Return the EventItem view using a model container
        return EventItem(item: item, onDelete: {}, onEdit: {})
            .modelContainer(container)
    } catch {
        fatalError("Failed to create ModelContainer: \(error)") // Error handling if the model container fails
    }
}

//
//  EventProgressBar.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 20.05.2024.
//

import SwiftUI

struct EventProgressBar: View {
    // An array of tasks related to the event
    var tasks: [Task]

    // Computed property to calculate the progress percentage
    var progress: Int {
        // Calculate the percentage of tasks completed
        return Int(Double(tasks.filter { $0.isDone }.count) / Double(tasks.count) * 100)
    }

    var body: some View {
        HStack {
            // ProgressView showing the number of completed tasks out of the total tasks
            ProgressView(value: Double(tasks.filter { $0.isDone }.count), total: Double(tasks.count))
                .progressViewStyle(LinearProgressViewStyle(tint: .oranzova)) // Custom style with tint color
                .frame(height: 10) // Fixed height for the progress bar
                .padding(.top, 4) // Padding to offset the progress bar slightly from other elements
            // Text view to display the computed progress percentage
            Text("\(progress) %")
                .font(.footnote) // Smaller font size for footnote style
                .foregroundColor(.bg) // Foreground color from the environment
        }
    }
}

// SwiftUI Preview for the EventProgressBar
#Preview {
    // Example preview with an empty array of tasks
    EventProgressBar(tasks: [])
}

//
//  EventTypeBadge.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 20.05.2024.
//

import SwiftUI

struct EventTypeBadge: View {
    // A constant holding the type of the event
    let type: EventType

    // Computed property to determine the color based on the event type
    var eventTypeColor: Color {
        switch type {
        case .midterm:
            return .orange // Orange color for midterm events
        case .final:
            return .red // Red color for final events
        case .general:
            return .gray // Gray color for general events
        case .project:
            return .blue // Blue color for project events
        }
    }

    var body: some View {
        // Display the event type text
        Text(type.rawValue.capitalized) // Capitalizes the raw value of the enum case
            .font(.caption2) // Sets the font size to caption2
            .bold() // Makes the font bold
            .foregroundColor(eventTypeColor) // Sets the text color to the event type color
            .padding(.horizontal, 10) // Adds horizontal padding around the text
            .padding(.vertical, 8) // Adds vertical padding around the text
            .background(eventTypeColor.opacity(0.2)) // Sets a background color with reduced opacity
            .cornerRadius(100) // Sets the corner radius to 100, making it fully rounded
            .overlay(
                // Adds a border around the badge with the same event type color
                RoundedRectangle(cornerRadius: 100)
                    .stroke(eventTypeColor, lineWidth: 1.5)
            )
    }
}

// SwiftUI Preview to visualize the EventTypeBadge component in Xcode's canvas
#Preview {
    // Displaying an instance of EventTypeBadge with 'final' type
    EventTypeBadge(type: .final)
}

//
//  GrainyTextureView.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 23.04.2024.
//

import SwiftUI

struct GrainyTextureView: View {
    var body: some View {
        // Displays a grainy texture image as a background
        Image("grainytexture") // Loads the image
            .resizable() // Allows the image to be resized
            .scaledToFill() // Ensures the image fills its container
            .blendMode(.overlay) // Sets the blend mode to overlay
            .opacity(0.25) // Reduces the opacity to blend subtly with the background
    }
}

// SwiftUI Preview for visual testing
#Preview {
    GrainyTextureView()
}

//
//  EventDashboard.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 20.05.2024.
//

import SwiftUI

struct EventDashboard: View {
    var events: [Event]
    var groupingOption: GroupingOption
    var deleteEvent: (Event) -> Void
    var editEvent: (Event) -> Void

    var body: some View {
        if events.isEmpty {
            Text("There's nothing here.")
                .font(.subheadline)
                .opacity(0.5)

        } else {
            Group {
                if groupingOption == .subject {
                    // Logic to display events grouped by subject
                    ForEach(groupedEventsBySubject(events).keys.sorted(), id: \.self) { subject in
                        VStack(alignment: .leading) {
                            Text(subject).font(.headline)
                            ForEach(groupedEventsBySubject(events)[subject]!, id: \.self) { event in
                                EventItem(item: event, onDelete: { deleteEvent(event) }, onEdit: { editEvent(event) })
                            }
                        }
                    }
                } else {
                    // Logic to display events in a single list
                    ForEach(events, id: \.self) { event in
                        EventItem(item: event, onDelete: { deleteEvent(event) }, onEdit: { editEvent(event) })
                    }
                }
            }
        }
    }

    // Helper function to group events by subject
    private func groupedEventsBySubject(_ events: [Event]) -> [String: [Event]] {
        Dictionary(grouping: events, by: { $0.subject })
    }
}

//
//  EventDashboardOptions.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 20.05.2024.
//

import SwiftUI

enum GroupingOption: String, CaseIterable {
    case none = "Don't group"
    case subject = "Group by subject"
}

enum SortingOption: String, CaseIterable {
    case date = "Order by date"
    case name = "Order by name"
}

enum SortingDirection: String, CaseIterable {
    case ascending = "Ascending"
    case descending = "Descending"
}

struct EventDashboardOptions: View {
    @Binding var groupingOption: GroupingOption
    @Binding var sortingOption: SortingOption
    @Binding var sortingDirection: SortingDirection

    var body: some View {
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

            Picker("Direction", selection: $sortingDirection) {
                ForEach(SortingDirection.allCases, id: \.self) { direction in
                    Text(direction.rawValue).tag(direction)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

//
//  Tutel.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 22.04.2024.
//

import SwiftUI

struct Tutel: View {
    var body: some View {
        Image("tutel")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay {
                Rectangle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
            .padding()
    }
}

#Preview {
    Tutel()
}

//
//  CustomSearchBar.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 18.05.2024.
//

import SwiftUI
import UIKit

struct CustomSearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = ""
            text = ""
            searchBar.resignFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.tintColor = UITraitCollection.current.userInterfaceStyle == .dark ? UIColor.oranzova : UIColor.bg
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

//
//  Item.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 23.04.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date

    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

//
//  Event.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 23.04.2024.
//

import Foundation
import SwiftData

// Enum defining possible event types, conforming to String and Codable for serialization
enum EventType: String, Codable, CaseIterable {
    case general
    case project
    case midterm
    case final
}

// Model class for an event, utilizing the @Model attribute for database operations in SwiftData
@Model
class Event {
    var title: String // Title of the event
    var subject: String // Subject or a brief description of the event
    var date: Date // Date and time when the event occurs
    var type: EventType // Type of the event, using the EventType enum
    var tasks: [Task] // List of tasks associated with the event

    // Initializer for creating an instance of Event
    init(title: String = "Name", subject: String = "Subject", date: Date = Date.now,
         type: EventType = EventType.general, tasks: [Task] = [])
    {
        self.title = title // Initializes the title with a default or provided value
        self.subject = subject // Initializes the subject with a default or provided value
        self.date = date // Initializes the date with a default or provided value (current date/time)
        self.type = type // Initializes the type with a default or provided value (general)
        self.tasks = tasks // Initializes the tasks with a default or provided empty array
    }
}

//
//  Task.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 15.05.2024.
//

import Foundation
import SwiftData

// Define a model class for a task, which conforms to the Identifiable protocol for use in SwiftUI views
@Model
class Task: Identifiable {
    var id: UUID = UUID() // Unique identifier for each task, automatically generated
    var text: String // Text description of the task
    var isDone: Bool // Boolean state to track whether the task is completed

    // Initializer for the Task class
    init(text: String = "Task Description", isDone: Bool = false) {
        self.text = text // Initialize the text property with a default or specified value
        self.isDone = isDone // Initialize the isDone property with a default value of false
    }
}

//
//  NavigationBarConfigurator.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 16.05.2024.
//

import SwiftUI

struct NavigationBarConfigurator: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    func setupColor() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()

        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: colorScheme == .dark ? UIColor.purple : .yellow]
        // Inline Navigation Title
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: colorScheme == .dark ? UIColor.purple : .yellow]

//                if colorScheme == .dark {
//                    appearance.backgroundColor = .black // Assuming .bg is similar to black
//                    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "oranzova") ?? .white]
//                    appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "oranzova") ?? .oranzova]
//                } else {
//                    appearance.backgroundColor = .white // Assuming .bg is similar to white
//                    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "bg") ?? .black]
//                    appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "bg") ?? .black]
//                }
//
//                UINavigationBar.appearance().standardAppearance = appearance
//                UINavigationBar.appearance().compactAppearance = appearance
//                UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    func body(content: Content) -> some View {
        content
            .onAppear(perform: setupColor)
        
        
    }
}

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

//
//  DetailView.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 23.04.2024.
//

import SwiftData
import SwiftUI

struct EventDetailView: View {
    @State private var item: Event // State to hold and manage the details of the event
    @State private var newTaskDescription: String = "" // State for holding new task descriptions

    init(item: Event) {
        _item = State(initialValue: item) // Initialize state with the given event
    }

    var body: some View {
        VStack {
            Form {
                EventForm(item: $item) // Reusable form for editing event details

                Section(header: Text("Tasks")) {
                    List {
                        ForEach($item.tasks) { $task in // Iterate over tasks, allowing for modification
                            HStack {
                                TextField("Task Description", text: $task.text) // Input for editing task description
                                Spacer()
                                Button(action: {
                                    task.isDone.toggle() // Toggle task completion state
                                }) {
                                    Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle") // Display checkmark if done
                                        .foregroundColor(task.isDone ? .green : .gray)
                                }
                            }
                        }
                        .onDelete(perform: deleteTask) // Swipe to delete task
                    }
                    HStack {
                        TextField("New Task", text: $newTaskDescription) // Input for new task
                        Button(action: addTask) { // Button to add new task
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Text("Edit event")) // Navigation bar title
    }

    // Function to add a new task to the event
    private func addTask() {
        guard !newTaskDescription.isEmpty else { return } // Check if the description is not empty
        let newTask = Task(text: newTaskDescription) // Create a new task
        item.tasks.append(newTask) // Append new task to the list
        newTaskDescription = "" // Reset input field
    }

    // Function to delete a task from the list
    private func deleteTask(at offsets: IndexSet) {
        item.tasks.remove(atOffsets: offsets) // Remove task at specified index
    }
}

// SwiftUI Preview for the EventDetailView
#Preview {
    EventDetailView(item: Event(title: "cus", subject: "tom")) // Provide a sample event for previewing
}

//
//  SheetContentView.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 23.04.2024.
//

import SwiftData
import SwiftUI

struct NewEventDrawer: View {
    @Environment(\.modelContext) var modelContext // Access to the model context for database operations
    @Environment(\.presentationMode) var presentationMode // Access to dismiss the view

    @State private var showingAlert = false // State to control alert visibility
    @State private var alertMessage = "" // State to hold the alert message

    // State to hold the event being created or edited
    @State private var item: Event = .init(title: "", subject: "", date: Date(), type: .general)

    var body: some View {
        NavigationView {
            Form {
                EventForm(item: $item) // Embeds the EventForm component for user input
            }
            .navigationTitle("Create Event") // Sets the navigation bar title
            .navigationBarTitleDisplayMode(.inline) // Inline display mode for the navigation title
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss() // Dismiss the drawer when the 'x' button is tapped
            }) {
                Image(systemName: "xmark") // 'x' icon
            }, trailing: Button(action: {
                saveEvent() // Calls saveEvent when the checkmark is tapped
            }) {
                Image(systemName: "checkmark") // 'checkmark' icon
            })
        }
        .alert(isPresented: $showingAlert) { // Alert presentation controlled by showingAlert state
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    // Function to save the event
    private func saveEvent() {
        // Validation for the event title
        guard !item.title.isEmpty else {
            alertMessage = "Title cannot be empty"
            showingAlert = true
            return
        }

        // Validation for the event subject
        guard !item.subject.isEmpty else {
            alertMessage = "Subject cannot be empty"
            showingAlert = true
            return
        }

        modelContext.insert(item) // Insert the new event into the model context
        presentationMode.wrappedValue.dismiss() // Dismiss the drawer on successful save
    }
}

// SwiftUI Preview for NewEventDrawer
struct SheetContentView_Previews: PreviewProvider {
    static var previews: some View {
        NewEventDrawer()
    }
}



//
//  iza_projektApp.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 23.04.2024.
//

import SwiftData
import SwiftUI

@main

struct iza_projektApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Event.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
//        .modelContainer(for: Event.self)
    }
}

