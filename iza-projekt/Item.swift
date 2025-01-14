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
