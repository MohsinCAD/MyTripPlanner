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

    var hasShownNewUser = false
    let hasShownNewUserBinding = Binding(
      get: { hasShownNewUser },
      set: { hasShownNewUser = $0 }
    )


    let _ = NewUserView(hasShownNewUserView: hasShownNewUserBinding)

    hasShownNewUserBinding.wrappedValue = true

    XCTAssertTrue(hasShownNewUser, "The hasShownNewUser should now be true.")
  }
}
