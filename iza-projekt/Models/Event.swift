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
