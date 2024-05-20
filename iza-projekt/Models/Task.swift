//
//  Task.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 15.05.2024.
//

import Foundation
import SwiftData

@Model
class Task: Identifiable {
    var id: UUID = UUID()
    var text: String
    var isDone: Bool
    
    init(text: String = "Task Description", isDone: Bool = false) {
        self.text = text
        self.isDone = isDone
    }
}
