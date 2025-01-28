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

           mapView.delegate = self
           mapView.showsUserLocation = true

           let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
           mapView.addGestureRecognizer(longPressGesture)
       }

       @objc func handleLongPress(gestureRecognizer: UIGestureRecognizer) {
           guard gestureRecognizer.state == .began else { return }

           let touchPoint = gestureRecognizer.location(in: mapView)
           let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)

           addAnnotation(at: touchCoordinate)
       }

       func addAnnotation(at coordinate: CLLocationCoordinate2D) {
           let annotation = MKPointAnnotation()
           annotation.coordinate = coordinate
           annotation.title = "New Pin"
           annotation.subtitle = "Added by user"

           mapView.addAnnotation(annotation)
       }

       // MARK: - MKMapViewDelegate

       func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
           guard let annotation = annotation as? MKPointAnnotation else { return nil }

           let identifier = "AnnotationView"

           var markerView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

           if markerView == nil {
               markerView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
               markerView?.canShowCallout = true
               markerView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

               // Customize marker appearance
               markerView?.markerTintColor = .blue // Sets the marker color
               markerView?.glyphText = "📍" // Sets a glyph (emoji or text) inside the marker
               //or a custom image
               //markerView?.glyphImage = UIImage(systemName: "mappin.and.ellipse")

           } else {
               markerView?.annotation = annotation
           }

           return markerView
       }

       func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
           guard let annotation = view.annotation else { return }

           if control == view.rightCalloutAccessoryView {
               print("Tapped detail disclosure for \(annotation.title ?? "No title")")

               // Example: Show an alert
               let alert = UIAlertController(title: annotation.title as! String, message: "Details for this pin.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default))
               present(alert, animated: true)

               // Or perform a segue:
               // performSegue(withIdentifier: "showDetail", sender: annotation)
           }
       }
       // Optional: Handle annotation selection/deselection
       func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
           print("Annotation selected: \(view.annotation?.title ?? "")")
       }

       func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
           print("Annotation deselected: \(view.annotation?.title ?? "")")
       }
   }
