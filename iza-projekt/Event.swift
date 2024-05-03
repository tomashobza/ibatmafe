//
//  Event.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 23.04.2024.
//

import Foundation
import SwiftData

enum EventType: String, Codable, CaseIterable {
    case midterm
    case final
    case general
    case project

    var description: String {
        switch self {
        case .midterm:
            return "Midterm"
        case .final:
            return "Final"
        case .general:
            return "General"
        case .project:
            return "Project"
        }
    }
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

    init(title: String = "Name", subject: String = "Subject", date: Date = Date.now, type: EventType = EventType.general, status: Status = Status.upcoming) {
        self.title = title
        self.subject = subject
        self.date = date
        self.type = type
        self.status = status
    }
}
