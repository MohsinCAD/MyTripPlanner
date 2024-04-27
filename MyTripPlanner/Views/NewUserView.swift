//
//  NewUserView.swift
//  MyTripPlanner
//
//  Created by Mohsin on 2024-04-25.
//

import SwiftUI

struct NewUserView: View {
  @Binding var hasShownNewUserView: Bool
  var body: some View {
    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
      .edgesIgnoringSafeArea(.all)
      .overlay(
        OnBoardingView(hasShownNewUserView: $hasShownNewUserView)
      )
  }
}
