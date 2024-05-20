//
//  SheetContentView.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 23.04.2024.
//

import SwiftData
import SwiftUI

struct NewEventDrawer: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    @State private var alertMessage = ""

    @State private var item: Event = .init(title: "", subject: "", date: Date(), type: .general)

    var body: some View {
        NavigationView {
            Form {
                EventForm(item: $item) // Use the new form component
            }
            .navigationTitle("Create Event")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
            }, trailing: Button(action: {
                saveEvent()
            }) {
                Image(systemName: "checkmark")
            })
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    private func saveEvent() {
        guard !item.title.isEmpty else {
            alertMessage = "Title cannot be empty"
            showingAlert = true
            return
        }

        guard !item.subject.isEmpty else {
            alertMessage = "Subject cannot be empty"
            showingAlert = true
            return
        }

        modelContext.insert(item)
        presentationMode.wrappedValue.dismiss()
    }
}

struct SheetContentView_Previews: PreviewProvider {
    static var previews: some View {
        NewEventDrawer()
    }
}