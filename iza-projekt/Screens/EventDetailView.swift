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
