//
//  LocationDetailView.swift
//  MyTripPlanner
//
//  Created by Mohsin on 2024-04-24.
//

import SwiftUI
import MapKit
import SwiftData

struct LocationDetailsView: View {
  @Environment(\.modelContext) private var context
  @State private var places: [Place] = []
  @Binding var mapSelection: MKMapItem?
  @Binding var show: Bool
  @State private var lookAroundScene: MKLookAroundScene?
  @Binding var getDirections: Bool
  @State private var showingAlert = false
  var body: some View {
    VStack {
      HStack {
        VStack(alignment: .leading) {
          Text(mapSelection?.placemark.name ?? "")
            .font(.title2)
            .fontWeight(.semibold)

          Text(mapSelection?.placemark.title ?? "")
            .font(.footnote)
            .foregroundStyle(.gray)
            .lineLimit(2)
            .padding(.trailing)
            }
        Spacer()

        Button {
          show.toggle()
          mapSelection = nil
        } label: {
          Image(systemName: "xmark.circle.fill")
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundStyle(.gray, Color(.systemGray6))
        }
      }

      if let scene = lookAroundScene {
        LookAroundPreview(initialScene: scene)
          .frame(height: 175)
          .cornerRadius(12)
          .padding()
      } else {
        ContentUnavailableView("No Preview Available", systemImage: "nosign")
      }
      HStack {
        Button {
          if let mapSelection {
            mapSelection.openInMaps()
          }
        } label: {
          Text("Open in Maps")
            .font(.title3)
            .foregroundColor(.white)
            .frame(width: 100, height: 50)
            .background(.green)
            .cornerRadius(12)
        }
        //  .buttonStyle(PlainButtonStyle())
        Button {
          getDirections = true
          show = false
        } label: {
          Text("Get Directions")
            .font(.title3)
            .foregroundColor(.white)
            .frame(width: 100, height: 50)
            .background(.blue)
            .cornerRadius(12)
        }
        // .buttonStyle(PlainButtonStyle())
        Button {
          let newPlace = Place(name: mapSelection?.placemark.name ?? "", title: mapSelection?.placemark.title ?? "", city: "Cupertino")
          places.append(newPlace)
          context.insert(newPlace)
          showingAlert = true
        } label: {
          Text("Add to List")
            .font(.title3)
            .foregroundColor(.white)
            .frame(width: 100, height: 50)
            .background(.purple)
            .cornerRadius(12)
        }
        .alert("Place has been saved to your list.", isPresented: $showingAlert) {
          Button("OK", role: .cancel) { }
        }
        .onAppear {
          fetchLookAroundPreview()
        }
        .onChange(of: mapSelection) { _, _ in
          fetchLookAroundPreview()
        }
      }
    }
  }
}
extension LocationDetailsView {
  func fetchLookAroundPreview () {
    if let mapSelection {
      lookAroundScene = nil
      Task {
        let request = MKLookAroundSceneRequest(mapItem: mapSelection)
        lookAroundScene = try? await request.scene
      }
    }
  }
}
