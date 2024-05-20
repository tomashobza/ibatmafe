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
