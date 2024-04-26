//
//  DestinationModel.swift
//  MyTripPlanner
//
//  Created by Mohsin on 2024-04-22.
//
import SwiftUI
import SwiftData

@Model
class Destination {
    
    var city: String
    var country: String
    var startDate: Date
    var endDate: Date
    var longitude: Double = 37.7749
    var latitude: Double = -122.4194
    
    init(city: String, country: String, startDate: Date, endDate: Date) {
        self.city = city
        self.country = country
        self.startDate = startDate
        self.endDate = endDate
        self.longitude = longitude
        self.latitude = latitude
    }
}

