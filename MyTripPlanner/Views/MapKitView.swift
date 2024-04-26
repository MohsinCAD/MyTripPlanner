
import SwiftUI
import MapKit
import SwiftData

struct MapKitView: View {
    @Environment(\.modelContext) private var context
    @Binding var destinations: [Destination]
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    @State private var searchText = ""
    @State private var results = [MKMapItem]()
    @State private var mapSelection: MKMapItem?
    @State private var showDetails = false
    @State internal var getDirections = false
    @State private var routeDisplaying = false
    @State private var route: MKRoute?
    @State private var routeDestination: MKMapItem?
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
                    let placemark = item.placemark
                    Marker(placemark.name ?? "", coordinate: placemark.coordinate)
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
                print("Search for location with query \(searchText)")
                Task { await searchPlaces() }
            }
            .onChange(of: mapSelection, { oldValue, newValue in
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
    private func geocodeAndSetMap(for city: String, in mapView: MKMapView, completion: @escaping ([CLLocationCoordinate2D]) -> Void) {
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
}

extension CLLocationCoordinate2D {
    static var userLocation:  CLLocationCoordinate2D {
        return .init(latitude: 37.3230, longitude: -122.0322)
    }
}

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation, latitudinalMeters: 10000, longitudinalMeters: 10000 )
        
    }
}






