//
//  OnBoardingView.swift
//  MyTripPlanner
//
//  Created by Mohsin on 2024-04-25.
//
import SwiftUI

struct OnBoardingView: View {
  @Binding var hasShownNewUserView: Bool
  @State internal var moveAirplane = false

  var body: some View {
    VStack {
      Spacer()
      Image(systemName: "airplane")
        .font(.largeTitle)
        .fontWeight(.bold)
        .offset(x: moveAirplane ? 0 : -UIScreen.main.bounds.width, y: 0)
        .animation(Animation.easeInOut(duration: 2).delay(0.5), value: moveAirplane)
        .onAppear {
          moveAirplane = true
        }

      if moveAirplane {
        VStack(spacing: 20) {
          Text("Create your itinerary list for your new trip!")
            .font(.title)
            .fontWeight(.medium)
            .padding()
            .transition(.opacity)
            .animation(Animation.easeIn(duration: 1).delay(2.5), value: moveAirplane)
            .transition(.opacity)
            .animation(Animation.easeIn(duration: 1).delay(3), value: moveAirplane)
        }
      }

      Spacer()
    }
  }
}
