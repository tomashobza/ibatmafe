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
