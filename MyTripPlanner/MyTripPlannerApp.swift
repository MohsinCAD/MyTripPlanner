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
    
//    let modelContainer: ModelContainer
//        
//        init() {
//            do {
//                modelContainer = try ModelContainer(for: Destination.self)
//            } catch {
//                fatalError("Could not initialize ModelContainer")
//            }
//        }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Destination.self, Place.self])
        }
    }
}
