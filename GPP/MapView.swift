//
//  MapView.swift
//  GPP
//
//  Created by Saša Marjanović on 17.01.2023..
//

import MapKit
import SwiftUI
import UIKit


class BusStopAnnotation: MKPointAnnotation {
    var busStop: BusStop
    init(busStop: BusStop) {
        self.busStop = busStop
        super.init()
        self.coordinate = CLLocationCoordinate2D(latitude: busStop.latitude, longitude: busStop.longitude)
        self.title = busStop.name
    }
}

let busStopCG = BusStop(name: "Centralno groblje",latitude: 45.53174983310974, longitude: 18.671850304788737)
let busStopS = BusStop(name: "Cesting", latitude: 45.53894023803806, longitude: 18.67270921720016)
let busStopN = BusStop(name: "Nadvoznjak", latitude: 45.54159885719651, longitude:  18.674880320881)
let busStopM = BusStop(name: "Mercator",latitude: 45.54480067313245, longitude: 18.677720239942886)

let busAnCG = BusStopAnnotation(busStop: busStopCG)
let busAnS = BusStopAnnotation(busStop: busStopS)
let busAnN = BusStopAnnotation(busStop: busStopN)
let busAnM = BusStopAnnotation(busStop: busStopM)

struct MapView: UIViewRepresentable {
    
    let osijekLocation = CLLocation(latitude: 45.5550, longitude: 18.6955)
    var annotations: [MKAnnotation] = [busAnCG, busAnS, busAnN, busAnM]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.centerToLocation(osijekLocation)
        view.addAnnotations(annotations)
        view.calculateRoute(annotations: annotations)
    }
    
    func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        init(_ parent: MapView) {
                self.parent = parent
            }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "busStop"
            if annotation is BusStopAnnotation {
                let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) ??
                    MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                let image = UIImage(named: "busStop")
                let size = CGSize(width: 44, height: 44)
                UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
                image?.draw(in: CGRect(origin: .zero, size: size))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                annotationView.image = resizedImage
                
                return annotationView
            }
            return nil
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if overlay is MKPolyline {
                let renderer = MKPolylineRenderer(overlay: overlay)
                renderer.strokeColor = .blue
                renderer.lineWidth = 5
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}


private extension MKMapView {
    
    func centerToLocation( _ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
          center: location.coordinate,
          latitudinalMeters: regionRadius,
          longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
    
    func calculateRoute(annotations: [MKAnnotation]) {
        var mapItems: [MKMapItem] = []
        for annotation in annotations {
            let placemark = MKPlacemark(coordinate: annotation.coordinate)
            let mapItem = MKMapItem(placemark: placemark)
            mapItems.append(mapItem)
        }

        let directionRequest = MKDirections.Request()
        directionRequest.transportType = .automobile
        directionRequest.source = mapItems.first
        directionRequest.destination = mapItems.last

        let directions = MKDirections(request: directionRequest)

        directions.calculate { (response, error) in
            guard let response = response else { return }
            let route = response.routes[0]
            self.addOverlay(route.polyline, level: .aboveRoads)
        }
    }
}
