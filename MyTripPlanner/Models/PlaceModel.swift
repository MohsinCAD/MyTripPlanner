//
//  PlaceMark.swift
//  MyTripPlanner
//
//  Created by Mohsin on 2024-04-25.
//

import SwiftUI
import SwiftData


@Model
class Place {
    var name: String
    var title: String
    
    init(name: String, title: String) {
        self.name = name
        self.title = title
    }
    
}


