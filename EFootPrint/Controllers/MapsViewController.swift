//
//  MapsViewController.swift
//  EFootPrint
//
//  Created by Joseph Mccole on 10/12/2024.
//

import UIKit
import MapKit
class MapsViewController: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
            super.viewDidLoad()

            mapView.delegate = self // Sets the view controller as the map view's delegate
            mapView.showsUserLocation = true // Shows the user's current location on the map

            // Adds a long press gesture recognizer to the map view
            let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
            mapView.addGestureRecognizer(longPressGesture)
        }

        // Handles the long press gesture
        @objc func handleLongPress(gestureRecognizer: UIGestureRecognizer) {
            // Only proceed if the gesture has just begun
            guard gestureRecognizer.state == .began else { return }

            // Gets the touch point in the map view's coordinate system
            let touchPoint = gestureRecognizer.location(in: mapView)
            // Converts the touch point to map coordinates (latitude and longitude)
            let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)

            // Adds an annotation at the touched coordinate
            addAnnotation(at: touchCoordinate)
        }

        // Adds a pin annotation to the map
        func addAnnotation(at coordinate: CLLocationCoordinate2D) {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "New Pin"
            annotation.subtitle = "Added by user"

            mapView.addAnnotation(annotation)
        }

        // MARK: - MKMapViewDelegate

        // Provides a view for each annotation on the map
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // Ensures we're dealing with a MKPointAnnotation
            guard let annotation = annotation as? MKPointAnnotation else { return nil }

            let identifier = "AnnotationView"

            // Tries to reuse an existing annotation view
            var markerView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

            if markerView == nil {
                // Creates a new marker view if none are available for reuse
                markerView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                markerView?.canShowCallout = true // Enables the callout (bubble)
                markerView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) // Adds a detail disclosure button to the callout

                // Customize marker appearance
                markerView?.markerTintColor = .blue // Sets the marker color to blue
                markerView?.glyphText = "📍" // Sets the glyph (icon) of the marker to a pin emoji
            } else {
                // Updates the annotation for the reused view
                markerView?.annotation = annotation
            }

            return markerView
        }

        // Called when the callout accessory control (detail disclosure button) is tapped
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let annotation = view.annotation else { return }

            if control == view.rightCalloutAccessoryView {
                print("Tapped detail disclosure for \(String(describing: annotation.title ?? "No title"))")

                // Example: Shows an alert with the annotation's title
                let alert = UIAlertController(title: annotation.title!!, message: "Details for this pin.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)

                // You could also perform a segue here to show more details:
                // performSegue(withIdentifier: "showDetail", sender: annotation)
            }
        }

        // Optional: Called when an annotation is selected
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            print("Annotation selected: \(String(describing: view.annotation?.title ?? ""))")
        }

        // Optional: Called when an annotation is deselected
        func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
            print("Annotation deselected: \(String(describing: view.annotation?.title ?? ""))")
        }
    }
