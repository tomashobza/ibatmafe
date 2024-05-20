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
