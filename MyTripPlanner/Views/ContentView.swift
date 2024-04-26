//
//  ContentView.swift
//  MyTripPlanner
//
//  Created by Mohsin on 2024-04-22.
//

import SwiftUI
import SwiftData
import MapKit

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @State private var city: String = ""
    @State private var country: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var destinations: [Destination] = []
    @State private var showingAddDestination = false
    @State private var showingLaunchScreen = true
    @State private var showOnboarding = false
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
 

    var body: some View {
        ZStack {
            
            TabView {
                NavigationStack {
                    ItineraryListView()
                        .navigationTitle("Itineraries")
                        .navigationBarItems(trailing: Button(action: {
                            showingAddDestination = true
                        }) {
                            Image(systemName: "plus")
                        })
                        .sheet(isPresented: $showingAddDestination) {
                            addDestinationForm
                        }
                }
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }

                MapKitView(destinations: $destinations)
                    .tabItem {
                        Label("Map", systemImage: "map")
                    }
            }
            .fullScreenCover(isPresented: $showOnboarding, onDismiss: {
                hasCompletedOnboarding = true
            }) {
                NewUserView(hasShownNewUserView: $hasCompletedOnboarding)
                    .onAppear {
                        self.autoDismissOnboarding(after: 5)
                    }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {  
                    showingLaunchScreen = false
                    if !hasCompletedOnboarding {
                        showOnboarding = true
                    }
                }
            }

            
            if showingLaunchScreen {
                LaunchScreenView()
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }

    internal var addDestinationForm: some View {
        NavigationView {
            Form {
                Section(header: Text("New Destination")) {
                    TextField("City", text: $city)
                    TextField("Country", text: $country)
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                }
                Button("Add Destination") {
                    addDestination()
                    showingAddDestination = false
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .navigationTitle("Add Destination")
            .navigationBarItems(leading: Button("Cancel") {
                showingAddDestination = false
            })
        }
    }

    internal func addDestination() {
        let newDestination = Destination(city: city, country: country, startDate: startDate, endDate: endDate)
        destinations.append(newDestination)
        context.insert(newDestination)
        clearForm()
    }

    internal func clearForm() {
        city = ""
        country = ""
        startDate = Date()
        endDate = Date()
    }
    
    private func autoDismissOnboarding(after seconds: Double) {
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                if showOnboarding {
                    showOnboarding = false  
                    hasCompletedOnboarding = true
                }
            }
        }
    
}
