import SwiftData
import Foundation
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var destinations: [Destination]
    @Environment(\.modelContext) private var context

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator

        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        if let firstDestination = destinations.first {
            geocodeAndSetMap(for: firstDestination.city, in: mapView)
        }
        updateAnnotations(from: mapView)
    }

    private func geocodeAndSetMap(for city: String, in mapView: MKMapView) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { (placemarks, error) in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                print("Geocoding error: \(error?.localizedDescription ?? "No details available.")")
                return
            }
            let center = location.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
            let region = MKCoordinateRegion(center: center, span: span)
            mapView.setRegion(region, animated: true)
                
                
        }
    }

    private func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        for destination in destinations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: destination.latitude, longitude: destination.longitude)
            annotation.title = destination.city
            mapView.addAnnotation(annotation)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
    }
}



//
//import Foundation
//import SwiftUI
//import MapKit

//
//struct MapView: UIViewRepresentable {
//    @Binding var destinations: [Destination]
//    @Environment(\.modelContext) private var context
//
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.delegate = context.coordinator
//
//        // Set the initial region with a span of 0.15
//        let initialLocation = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194) // Example coordinates (San Francisco)
//        let span = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
//        let region = MKCoordinateRegion(center: initialLocation, span: span)
//        mapView.setRegion(region, animated: true)
//
//        return mapView
//    }
//
//    func updateUIView(_ mapView: MKMapView, context: Context) {
//        updateAnnotations(from: mapView)
//
//        
//        var region = mapView.region
//        region.span = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
//        mapView.setRegion(region, animated: true)
//    }
//
//    private func updateAnnotations(from mapView: MKMapView) {
//        mapView.removeAnnotations(mapView.annotations)
//        for destination in destinations {
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = CLLocationCoordinate2D(latitude: destination.latitude, longitude: destination.longitude)
//            annotation.title = destination.city
//            mapView.addAnnotation(annotation)
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    class Coordinator: NSObject, MKMapViewDelegate {
//        var parent: MapView
//
//        init(_ parent: MapView) {
//            self.parent = parent
//        }
//
//        
//    }
//}



















//import Foundation
//import SwiftUI
//import MapKit
//import SwiftData
//
//struct MapView: UIViewRepresentable {
//    @Binding var destinations: [Destination]
//    @Environment(\.modelContext) private var context
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.delegate = context.coordinator
//        return mapView
//    }
//
//    func updateUIView(_ mapView: MKMapView, context: Context) {
//        updateAnnotations(from: mapView)
//    }
//
//    private func updateAnnotations(from mapView: MKMapView) {
//        mapView.removeAnnotations(mapView.annotations)  
//        for destination in destinations {
//            annotateLocationOnMap(city: destination.city, mapView: mapView)
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    class Coordinator: NSObject, MKMapViewDelegate {
//        var parent: MapView
//
//        init(_ parent: MapView) {
//            self.parent = parent
//        }
//    }
//}
//
