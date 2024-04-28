//
//  DestinationDetailView.swift
//  MyTripPlanner
//
//  Created by Mohsin on 2024-04-26.
//

import SwiftUI
import SwiftData

struct DestinationDetailView: View {
@Environment(\.modelContext)
  private var context
  @Query var destinations: [Destination]
  @Query var places: [Place]
  @State private var imageUrl: URL?
  let pexelsService = PexelsService()

  var destination: Destination

  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      if let imageUrl = imageUrl {
        AsyncImage(url: imageUrl) { phase in
          switch phase {
          case .empty:

            ProgressView()
          case .success(let image):

            image.resizable()
              .aspectRatio(contentMode: .fit)
          case .failure:

            Text("Unable to load image")
              .foregroundColor(.gray)
          @unknown default:
            EmptyView()
          }
        }
      } else {
        Text("Loading Image...")
          .foregroundColor(.gray)
      }
      Text(destination.city + ", " + destination.country)
        .font(.largeTitle)
      Text("Start Date: \(destination.startDate, formatter: dateFormatter)")
      Text("End Date: \(destination.endDate, formatter: dateFormatter)")
      Text("Travel days: \(daysBetween(startDate: destination.startDate, endDate: destination.endDate))")
      List {
        Text("Your Saved Places")
          .font(.largeTitle)

        if destination.city == "Cupertino" {
          ForEach(places, id: \.self) { place in
            Group {
              Text(place.name)
                .font(.title3)
              Text("Address:  \(place.title)")
                .font(.subheadline)
            }
          }
        }
      }
    }
    .padding()
    .navigationTitle("Destination Details")
    .onAppear {
      pexelsService.fetchImageURL(city: destination.city) { url in
        DispatchQueue.main.async {
          self.imageUrl = url
        }
      }
    }
  }

  internal var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
  }

  func daysBetween(startDate: Date, endDate: Date) -> Int {
    let components = Calendar.current.dateComponents([.day], from: startDate, to: endDate)
    return components.day ?? 0
  }
}
