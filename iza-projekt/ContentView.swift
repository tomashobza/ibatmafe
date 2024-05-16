//
//  ContentView.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 22.04.2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.colorScheme) var colorScheme
    @Query var events: [Event]

    @State private var showingSheet = false // State for showing the sheet
    @State private var navigationPath = NavigationPath() // State for the navigation path
    @State private var selectedEvent: Event? // State for the selected event to edit

    init() {
        // Customize the navigation bar appearance
        let appearance = UINavigationBarAppearance()
        let font = UIFont(name: "Lora", size: 34)!

        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: "oranzova") ?? .white,
        ]

        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(named: "oranzova") ?? .white,
            .font: font,
        ]

        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: "Lora", size: 34)!]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance

        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().tintColor = .clear
        UINavigationBar.appearance().backgroundColor = .clear
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack(alignment: .top) {
                ScrollView {
                    // Scrollable content
                    VStack(spacing: 20) {
                        ForEach(events, id: \.self) { event in
                            EventItem(item: event, onDelete: {
                                deleteEvent(event)
                            }, onEdit: {
                                navigationPath.append(event)
                            })
                        }
                        Rectangle().frame(height: 30).opacity(0)
                    }
//                    .offset(y: 90)
                    .offset(y: 10)
                    .padding(.horizontal)
                }
//                // Title
//                HStack {
//                    Text("Your dashboard")
//                        .font(.custom("Lora", size: 32, relativeTo: .body))
//                        .padding()
//
//                    Spacer()
//
//                    HStack {
//                        Button(action: {
//                            showingSheet = true
//                        }) {
//                            Image(systemName: "plus")
//                        }
//                        .font(.title2)
//
//                        Button(action: {
//                            deleteAllEvents()
//                        }) {
//                            Image(systemName: "trash")
//                        }
//                        .font(.title2)
//                        .padding()
//                    }
//                }
//                .padding(.vertical)
//                .foregroundStyle(colorScheme == .dark ? .oranzova : .bg)
//                .background(
//                    LinearGradient(
//                        gradient: Gradient(colors: [(colorScheme == .dark ? Color.bg : Color.oranzova).opacity(1), (colorScheme == .dark ? Color.bg : Color.oranzova).opacity(0)]),
//                        startPoint: .top,
//                        endPoint: .bottom
//                    )
//                    .edgesIgnoringSafeArea(.vertical)
//                )
            }
            .background(
                GrainyTextureView()
                    .opacity(0.5)
                    .ignoresSafeArea(.all)
            )
            .background(colorScheme == .dark ? .bg : .oranzova)
            .edgesIgnoringSafeArea(.bottom)
            .sheet(isPresented: $showingSheet) {
                NewEventDrawer()
            }
            .navigationDestination(for: Event.self) { event in
                EventDetailView(item: event)
            }
            .navigationTitle(
                Text("Events")
            )
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    HStack {
                        Button(action: {
                            showingSheet = true
                        }) {
                            Image(systemName: "plus")
                        }
                        .font(.title2)
                        .foregroundStyle(.bg)
                    }
                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        deleteAllEvents()
//                    }) {
//                        Image(systemName: "trash")
//                    }
//                    .font(.title2)
//                }
            }
            .toolbarBackground(.clear)
        }
    }

    func addSamples() {
        let event = Event(subject: "Test event", date: Date())
        modelContext.insert(event)
    }

    func deleteEvent(_ event: Event) {
        modelContext.delete(event)
    }

    func deleteEvents(_ indexSet: IndexSet) {
        for index in indexSet {
            let event = events[index]
            modelContext.delete(event)
        }
    }

    func deleteAllEvents() {
        for event in events {
            modelContext.delete(event)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Event.self, configurations: config)

        let sampleEvent = Event(title: "cus", subject: "tom")
        container.mainContext.insert(sampleEvent)

        return ContentView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create ModelContainer: \(error)")
    }
}
