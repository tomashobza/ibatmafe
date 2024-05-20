//
//  EventProgressBar.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 20.05.2024.
//

import SwiftUI

struct EventProgressBar: View {
    var tasks: [Task]
    
    var progress: Int {
        return Int(Double(tasks.filter { $0.isDone }.count) / Double(tasks.count) * 100)
    }

    var body: some View {
        HStack {
            ProgressView(value: Double(tasks.filter { $0.isDone }.count), total: Double(tasks.count))
                .progressViewStyle(LinearProgressViewStyle(tint: .oranzova))
                .frame(height: 10)
                .padding(.top, 4)
            Text("\(progress) %")
                .font(.footnote)
                .foregroundColor(.bg)
        }
    }
}

#Preview {
    EventProgressBar(tasks: [])
}
