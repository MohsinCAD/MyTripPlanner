//
//  MapKitViewTests.swift
//  MyTripPlannerTests
//
//  Created by Mohsin on 2024-04-26.
//
import XCTest
@testable import MyTripPlanner
import MapKit
import SwiftUI

class MapKitViewTests: XCTestCase {
func testUpdateMapForCityWithValidCity() {
  let mapKitView = MapKitView()
  let mapView = MKMapView()
  let expectation = self.expectation(description: "Geocode expectation")

    mapKitView.geocodeAndSetMap(for: "San Francisco", in: mapView) { coordinates in
      XCTAssertFalse(coordinates.isEmpty, "Coordinates should be found for San Francisco")
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 5.0)
    }

    func testUpdateMapForCityWithInvalidCity() {
    let mapKitView = MapKitView()
    let mapView = MKMapView()
    let expectation = self.expectation(description: "Geocode expectation")
      mapKitView.geocodeAndSetMap(for: "Unknown City", in: mapView) { coordinates in
        XCTAssertTrue(coordinates.isEmpty, "No coordinates should be found for an unknown city")
          expectation.fulfill()
      }

    wait(for: [expectation], timeout: 5.0)
    }
}
