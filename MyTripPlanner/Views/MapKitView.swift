import SwiftUI
import MapKit
import SwiftData

struct MapKitView: View {
  @Environment(\.modelContext) private var context
  @Binding var destinations: [Destination]
  @State internal var cameraPosition: MapCameraPosition = .region(.userRegion)
  @State internal var searchText = ""
  @State internal var results = [MKMapItem]()
  @State internal var mapSelection: MKMapItem?
  @State internal var showDetails = false
  @State internal var getDirections = false
  @State internal var routeDisplaying = false
  @State internal var route: MKRoute?
  @State internal var routeDestination: MKMapItem?
  var body: some View {
    ZStack {
      Map(position: $cameraPosition, selection: $mapSelection) {
        Annotation("My location", coordinate: .userLocation) {
          ZStack {
            Circle()
              .frame(width: 32, height: 32)
              .foregroundColor(.blue.opacity(0.25))
            Circle()
              .frame(width: 20, height: 20)
              .foregroundColor(.white)
            Circle()
              .frame(width: 12, height: 12)
              .foregroundColor(.blue)
          }
        }
        ForEach(results, id: \.self) { item in
          if item == routeDestination {
            let placemark = item.placemark
            Marker(placemark.name ?? "", coordinate: placemark.coordinate)
          } else {
            let placemark = item.placemark
            Marker(placemark.name ?? "", coordinate: placemark.coordinate)
            }
        }
        if let route {
          MapPolyline(route.polyline)
            .stroke(.blue, lineWidth: 6)
        }
      }
      .onAppear {
      }
      .overlay(alignment: .top) {
        TextField("Search for a location...", text: $searchText)
          .textFieldStyle(.roundedBorder)
          .font(.subheadline)
          .padding(12)
          .background(.white)
          .shadow(radius: 10)
      }
      .onSubmit(of: .text) {
        route = nil 
        print("Search for location with query \(searchText)")
        Task { await searchPlaces() }
      }
      .onChange(of: getDirections, { oldValue, newValue in
        if newValue {
           fetchRoute()
        }
      })
      .onChange(of: mapSelection, { _, newValue in
        showDetails = newValue != nil
      })
      .sheet(isPresented: $showDetails, content: {
        LocationDetailsView(mapSelection: $mapSelection, show: $showDetails, getDirections: $getDirections)
          .presentationDetents([.height(340)])
          .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
          .presentationCornerRadius(12)
      })
      .mapControls {
        MapCompass()
        MapPitchToggle()
        MapUserLocationButton()
      }
    }
  }
  func updateMapForCity() {
    let mapView = MKMapView()

    geocodeAndSetMap(for: destinations.first!.city, in: mapView) { coordinates in
      if coordinates.isEmpty {
        print("No coordinates found for the specified city.")
      } else {
        //  CLLocationCoordinate2D(latitude: destinations.latitude, longitude: destinations.longitude)

        print("Coordinates: \(coordinates)")
      }
    }
  }
  internal func geocodeAndSetMap(for city: String, in mapView: MKMapView, completion: @escaping ([CLLocationCoordinate2D]) -> Void) {
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(city) { (placemarks, error) in
      var coordinates = [CLLocationCoordinate2D]()

      if let error = error {
        print("Geocoding error: \(error.localizedDescription)")
        completion(coordinates)
        return
      }

      if let placemark = placemarks?.first, let location = placemark.location {
        let center = location.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
        coordinates.append(center)
      }

      completion(coordinates)
    }
  }
}

extension MapKitView {
  func searchPlaces() async {
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = searchText
    request.region = .userRegion

    let results = try? await MKLocalSearch(request: request).start()
    self.results = results?.mapItems ?? []
  }
  func fetchRoute() {
    if let mapSelection {
      let request = MKDirections.Request()
      request.source = MKMapItem(placemark: .init(coordinate: .userLocation))
      request.destination = mapSelection

      Task {
        let result = try? await MKDirections(request: request).calculate()
        route = result?.routes.first
        routeDestination = mapSelection
        withAnimation {
          routeDisplaying = true
          showDetails = false

          if let rect = route?.polyline.boundingMapRect, routeDisplaying {
            cameraPosition = .rect(rect)
          }
        }

      }
    }
  }


}

extension CLLocationCoordinate2D {
  static var userLocation: CLLocationCoordinate2D {
    return .init(latitude: 37.3230, longitude: -122.0322)
  }
}

extension MKCoordinateRegion {
  static var userRegion: MKCoordinateRegion {
    return .init(center: .userLocation, latitudinalMeters: 10000, longitudinalMeters: 10000 )
  }
}
