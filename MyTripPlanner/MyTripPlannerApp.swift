//
//  MyTripPlannerApp.swift
//  MyTripPlanner
//
//  Created by Mohsin on 2024-04-22.
//

import SwiftUI
import SwiftData

@main
struct MyTripPlannerApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .modelContainer(for: [Destination.self, Place.self])
    }
  }
}
