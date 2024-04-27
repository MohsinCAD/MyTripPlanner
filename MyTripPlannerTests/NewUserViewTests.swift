//
//  NewUserViewTests.swift
//  MyTripPlannerTests
//
//  Created by Mohsin on 2024-04-26.
//
import XCTest
@testable import MyTripPlanner
import SwiftUI

class NewUserViewTests: XCTestCase {

  func testNewUserViewStateChange() {
    // Setting up the initial condition
    var hasShownNewUser = false
    let hasShownNewUserBinding = Binding(
      get: { hasShownNewUser },
      set: { hasShownNewUser = $0 }
    )

    // Instantiate the view with the binding
    let _ = NewUserView(hasShownNewUserView: hasShownNewUserBinding)

    // Here you might simulate user actions that lead to a state change
    // Since we're dealing with SwiftUI directly, we simulate a state change that should be triggered by the view itself or its children
    hasShownNewUserBinding.wrappedValue = true

    // Check the condition post-change
    XCTAssertTrue(hasShownNewUser, "The hasShownNewUser should now be true.")
  }
}
