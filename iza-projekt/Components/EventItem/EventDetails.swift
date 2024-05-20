//
//  EventDetails.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 20.05.2024.
//

import SwiftUI

struct EventDetails: View {
    var title: String
    var subject: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.title2)
                .foregroundColor(.bg)
            Text(subject)
                .font(.subheadline)
                .foregroundColor(.bg)
        }
    }
}

#Preview {
    EventDetails(title: "test", subject: "ABC")
}
