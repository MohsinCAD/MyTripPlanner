//
//  onBoardingViewTests.swift
//  MyTripPlannerTests
//
//  Created by Mohsin on 2024-04-26.
//

import XCTest
@testable import MyTripPlanner
import SwiftUI

class OnBoardingViewTests: XCTestCase {

  func testOnBoardingViewAnimationTrigger() {

    var hasShownNewUser = false
    let hasShownNewUserBinding = Binding(
      get: { hasShownNewUser },
      set: { hasShownNewUser = $0 }
    )


    let _ = OnBoardingView(hasShownNewUserView: hasShownNewUserBinding)




    func testOnBoardingViewTextVisibility() {

      var hasShownNewUser = false
      let hasShownNewUserBinding = Binding(
        get: { hasShownNewUser },
        set: { hasShownNewUser = $0 }
      )
      let onBoardingView = OnBoardingView(hasShownNewUserView: hasShownNewUserBinding)



      DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        XCTAssertTrue(onBoardingView.moveAirplane, "Text should be visible after animations complete.")
      }
    }
  }
}
