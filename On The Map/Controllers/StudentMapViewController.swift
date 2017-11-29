//
//  StudentMapViewController.swift
//  On The Map
//
//  Created by Octavius on 11/8/17.
//  Copyright © 2017 Delfyette Designs. All rights reserved.
//

import UIKit
import MapKit

class StudentMapViewController: UIViewController {
    
    //MARK: Variables
    
    @IBOutlet weak var mapView: MKMapView!
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "LoadingStudentsViewController") as! LoadingStudentsViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setPins()
    }
}

//MARK: MAP Delegates

extension StudentMapViewController: MKMapViewDelegate{
    func setPins(){
        var annotations = [MKPointAnnotation]()
        if(ParseStudentLocationSharedInstance.sharedInstance.studentLocations != nil){
            for student in ParseStudentLocationSharedInstance.sharedInstance.studentLocations{
                
                if let latitude = student.latitude, let longitude = student.longitude{
                    let lat = CLLocationDegrees(latitude)
                    let long = CLLocationDegrees(longitude)
                    
                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    annotation.title = StringFormat.formatNameText(firstName: student.firstName, lastName: student.lastName)
                    
                    if let mediaURL = student.mediaURL{
                        annotation.subtitle = mediaURL
                    }else{
                        annotation.subtitle = "[No Media URL]"
                    }
                    
                    annotations.append(annotation)
                }
            }
            self.mapView.removeAnnotations(mapView.annotations)
            self.mapView.addAnnotations(annotations)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                if(ValidateURL.isValidURL(urlString: toOpen)){
                    app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
                }else{
                    ValidateURL.showInvalidUrlMessage(viewCtrl: self)
                }
            }
        }
    }
}
