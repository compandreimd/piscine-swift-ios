//
//  FirstViewController.swift
//  test
//
//  Created by Admin on 25.04.17.
//  Copyright © 2017 Admintrst. All rights reserved.
//

import UIKit
import Foundation
import MapKit




class FirstViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate
{
    
    @IBOutlet weak var map: MKMapView!
    static var whatPinShow = 0
    var locationManager = CLLocationManager()
    var me = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    
        map.showsUserLocation = true
        displayPins()
    
    }

    @IBAction func onMe(_ sender: Any)
    {
        me = true
        if map.userLocation.location != nil
        {
            let span = MKCoordinateSpanMake(0.01, 0.01)
            let region = MKCoordinateRegion(center: map.userLocation.location!.coordinate, span: span)
            map.setRegion(region, animated: true)
        }
        else
        {
        }
    }
    
    @IBAction func onChange(_ sender: UISegmentedControl)
    {
        print(sender.selectedSegmentIndex)
        switch sender.selectedSegmentIndex {
        case 0:
            map.mapType = .hybrid
            break;
        case 1:
            map.mapType = .satellite
            break;
        default:
            map.mapType = .standard
        }
    }

    func displayPins()
    {
        for i in 0 ... (SecondViewController.pins.count - 1)
        {
            let pin = SecondViewController.pins[i]
            let annotation = MKPointAnnotation()
            let location = CLLocationCoordinate2DMake(pin.coordinate_x, pin.coordinate_y)
            annotation.coordinate = location
            annotation.title = pin.name
            annotation.subtitle = pin.title
            //annotations.append(annotation)
            map.addAnnotation(annotation)
            if (i == FirstViewController.whatPinShow)
            {
                let span = MKCoordinateSpanMake(0.01, 0.01)
                let region = MKCoordinateRegion(center: location, span: span)
                map.setRegion(region, animated: true)
            }
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinTintColor = .green
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if(me)
        {
            let location = locations.last! as CLLocation
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.map.setRegion(region, animated: true)
        }
    }

}

