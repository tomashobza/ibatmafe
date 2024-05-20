//
//  SheetContentView.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 23.04.2024.
//

import SwiftData
import SwiftUI

struct NewEventDrawer: View {
    @Environment(\.modelContext) var modelContext // Access to the model context for database operations
    @Environment(\.presentationMode) var presentationMode // Access to dismiss the view

    @State private var showingAlert = false // State to control alert visibility
    @State private var alertMessage = "" // State to hold the alert message

    // State to hold the event being created or edited
    @State private var item: Event = .init(title: "", subject: "", date: Date(), type: .general)

    var body: some View {
        NavigationView {
            Form {
                EventForm(item: $item) // Embeds the EventForm component for user input
            }
            .navigationTitle("Create Event") // Sets the navigation bar title
            .navigationBarTitleDisplayMode(.inline) // Inline display mode for the navigation title
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss() // Dismiss the drawer when the 'x' button is tapped
            }) {
                Image(systemName: "xmark") // 'x' icon
            }, trailing: Button(action: {
                saveEvent() // Calls saveEvent when the checkmark is tapped
            }) {
                Image(systemName: "checkmark") // 'checkmark' icon
            })
        }
        .alert(isPresented: $showingAlert) { // Alert presentation controlled by showingAlert state
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    // Function to save the event
    private func saveEvent() {
        // Validation for the event title
        guard !item.title.isEmpty else {
            alertMessage = "Title cannot be empty"
            showingAlert = true
            return
        }

        // Validation for the event subject
        guard !item.subject.isEmpty else {
            alertMessage = "Subject cannot be empty"
            showingAlert = true
            return
        }

        modelContext.insert(item) // Insert the new event into the model context
        presentationMode.wrappedValue.dismiss() // Dismiss the drawer on successful save
    }
}

// SwiftUI Preview for NewEventDrawer
struct SheetContentView_Previews: PreviewProvider {
    static var previews: some View {
        NewEventDrawer()
    }
}
