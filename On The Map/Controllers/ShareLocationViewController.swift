//
//  ShareLocationViewController.swift
//  On The Map
//
//  Created by Octavius on 11/10/17.
//  Copyright © 2017 Delfyette Designs. All rights reserved.
//

import UIKit
import MapKit

class ShareLocationViewController: UIViewController {

    //MARK: Variables
    
    var studentLocation: String!
    var studentMediaLink: String!
    var studentLong: Double!
    var studentLat: Double!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: LifeCycles
    
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.alpha = 0
        setPin()
    }
    
    //MARK: Action Buttons
    
    @IBAction func submitStudent(_ sender: Any) {
        setStudentLocation()
        
        ParseClient.sharedInstance().postNewStudent() { (success, errorString) in
            if success {
                let alert = UIAlertController(title: "Thanks", message: "You've shared you're location successfully!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default) { (action: UIAlertAction) in
                    self.navigationController?.popToRootViewController(animated: true)
                })
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "Could not save you're location.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: Helpers
    
    func setStudentLocation(){
        ParseClient.sharedInstance().mediaUrl = studentMediaLink
        ParseClient.sharedInstance().mapString = studentLocation
        ParseClient.sharedInstance().latitude = studentLat
        ParseClient.sharedInstance().longitude = studentLong
    }
}

extension ShareLocationViewController: MKMapViewDelegate{
    func setPin(){
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(studentLocation){
            (placemarks, error) in
            if(placemarks != nil){
                let placemark = MKPlacemark(placemark: placemarks![0])
                self.mapView.addAnnotation(placemark)
                let center = placemark.coordinate
                self.studentLat = placemark.coordinate.latitude
                self.studentLong = placemark.coordinate.longitude
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                self.mapView.setRegion(region, animated: true)
            }else{
                self.navigationController?.popViewController(animated: true)
                let alert = UIAlertController(title: "Could not find location", message: "Please enter a different location", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            performUIUpdatesOnMain {
                self.activityIndicator.alpha = 0
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        studentLat = location!.coordinate.latitude
        studentLong = location!.coordinate.longitude
        
        let center = CLLocationCoordinate2D(latitude: studentLat, longitude: studentLong)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        self.mapView.setRegion(region, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
}
extension ShareLocationViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
