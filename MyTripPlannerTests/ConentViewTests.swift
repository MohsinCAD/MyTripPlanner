//
//  ConentViewTests.swift
//  MyTripPlannerTests
//
//  Created by Mohsin on 2024-04-24.
//

import XCTest

@testable import MyTripPlanner

final class ConentViewTests: XCTestCase {

  func testInitialStates() {
    let contentView = ContentView()
    XCTAssertEqual(contentView.city, "")
    XCTAssertEqual(contentView.country, "")
    XCTAssertTrue(contentView.destinations.isEmpty)
    XCTAssertFalse(contentView.showingAddDestination)
  }

}
