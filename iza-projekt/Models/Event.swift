//
//  Event.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 23.04.2024.
//

import Foundation
import SwiftData

enum EventType: String, Codable, CaseIterable {
    case general
    case project
    case midterm
    case final
}

enum Status: Codable {
    case upcoming
    case inProgress
    case done

    var description: String {
        switch self {
        case .upcoming:
            return "Upcoming"
        case .inProgress:
            return "In Progress"
        case .done:
            return "Done"
        }
    }
}

@Model
class Event {
    var title: String
    var subject: String
    var date: Date
    var type: EventType
    var status: Status
    var tasks: [Task]

    init(title: String = "Name", subject: String = "Subject", date: Date = Date.now, type: EventType = EventType.general, status: Status = Status.upcoming, tasks: [Task] = []) {
        self.title = title
        self.subject = subject
        self.date = date
        self.type = type
        self.status = status
        self.tasks = tasks
    }
    
    var progress: Int {
        return Int(Double(tasks.filter { $0.isDone }.count) / Double(tasks.count) * 100)
    }
}
