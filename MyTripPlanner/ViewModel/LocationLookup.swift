//
//  LocationLookup.swift
//  MyTripPlanner
//
//  Created by Mohsin on 2024-04-22.
//

import Foundation
import MapKit
import SwiftData

func lookupLocation(city: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
  let searchRequest = MKLocalSearch.Request()
  searchRequest.naturalLanguageQuery = city
  let search = MKLocalSearch(request: searchRequest)
  search.start { response, error in
    guard let coordinate = response?.mapItems.first?.placemark.coordinate else {
      print("Location not found: \(error?.localizedDescription ?? "Unknown error")")
      completion(nil)
      return
    }
    completion(coordinate)
  }
}

func annotateLocationOnMap(city: String, mapView: MKMapView) {
  lookupLocation(city: city) { coordinate in
    guard let coordinate = coordinate else { return }
    let annotation = MKPointAnnotation()
    annotation.title = city
    annotation.coordinate = coordinate
    mapView.addAnnotation(annotation)
  }
}
