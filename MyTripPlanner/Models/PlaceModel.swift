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
  var city: String

  init(name: String, title: String, city: String) {
    self.name = name
    self.title = title
    self.city = city
  }
}
