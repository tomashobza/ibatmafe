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
    @State private var newTaskDescription: String = ""

    init(item: Event) {
        _item = State(initialValue: item)
    }

    var body: some View {
        VStack {
            Form {
                Section(header: Text("General")) {
                    TextField("Title", text: $item.title)
                    TextField("Subject", text: $item.subject)
                    DatePicker("Date", selection: $item.date)
                }

                Section("Type") {
                    Picker("Type", selection: $item.type) {
                        Text("General").tag(EventType.general)
                        Text("Project").tag(EventType.project)
                        Text("Final").tag(EventType.final)
                        Text("Midterm").tag(EventType.midterm)
                    }
                }

                Section(header: Text("Tasks")) {
                    List {
                        ForEach($item.tasks) { $task in
                            HStack {
                                TextField("Task Description", text: $task.text)
                                Spacer()
                                Button(action: {
                                    task.isDone.toggle()
                                }) {
                                    Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(task.isDone ? .green : .gray)
                                }
                            }
                        }
                        .onDelete(perform: deleteTask)
                    }
                    HStack {
                        TextField("New Task", text: $newTaskDescription)
                        Button(action: addTask) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(
            Text("Edit event")
        )
    }

    private func addTask() {
        guard !newTaskDescription.isEmpty else { return }
        let newTask = Task(text: newTaskDescription)
        item.tasks.append(newTask)
        newTaskDescription = ""
    }

    private func deleteTask(at offsets: IndexSet) {
        item.tasks.remove(atOffsets: offsets)
    }
}

#Preview {
    EventDetailView(item: Event(title: "cus", subject: "tom"))
}
