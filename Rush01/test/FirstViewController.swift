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

protocol HandleMapSearch {
    func dropPinZoomIn(_ placemark:MKPlacemark)
}


extension MKPinAnnotationView{
 
   func  getDirection()
   {
        let place = MKPlacemark(coordinate: self.annotation!.coordinate)
        let mapItem = MKMapItem(placemark: place)
        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
    
    }
  
}


class FirstViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate, HandleMapSearch
{
    
    @IBOutlet weak var map: MKMapView!
    static var whatPinShow = -1
    var locationManager = CLLocationManager()
    var me = true
    var resultSearchController:UISearchController!
    var touchR:UILongPressGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        let locationTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        locationTable.map = map
        locationTable.handleMap = self
        resultSearchController = UISearchController(searchResultsController: locationTable)
        resultSearchController?.searchResultsUpdater = locationTable
        let searchBar = resultSearchController.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder="Location"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        touchR = UILongPressGestureRecognizer(target: self, action: #selector(onTap(_:)))
        touchR.minimumPressDuration = 1
        map.addGestureRecognizer(touchR)
        
        displayPins()
    
    }

    
    func onTap(_ recognizer: UIGestureRecognizer)
    {
        let pos = self.touchR.location(in: self.map)
        let cord = self.map.convert(pos, toCoordinateFrom: self.map)
        let alertController = UIAlertController(title: "Add", message: "Add Point?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {
            action in
            let pin = Pin(name: (alertController.textFields?[0].text)!, title: "", x: cord.latitude, y: cord.longitude)
            SecondViewController.pins.append(pin)
            let view = self.tabBarController?.viewControllers?[1] as! SecondViewController
            if (view.table != nil)
            {
                view.table.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
         self.displayPins()
        self.navigationController?.tabBarController?.selectedIndex = 1
    }
    
    @IBAction func onMe(_ sender: Any)
    {
        me = true
        if map.userLocation.location != nil
        {
            let span = MKCoordinateSpanMake(0.05, 0.05)
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
        map.removeAnnotations(map.annotations)
        if (SecondViewController.pins.count > 0)
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
        }
        else {
            pinView!.annotation = annotation
        }
        pinView!.canShowCallout = true
        pinView!.pinTintColor = .orange
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.setBackgroundImage(UIImage(named:"car"), for: .normal)
        button.addTarget(pinView, action: #selector(pinView?.getDirection), for: .touchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if(me)
        {
            let location = locations.last! as CLLocation
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            self.map.setRegion(region, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        let view = mapView.subviews[0]
        for recognizer in view.gestureRecognizers!
        {
            if recognizer.state == .began || recognizer.state == .ended
            {
                me = false
            }
        }
    }
    
    func dropPinZoomIn(_ placemark:MKPlacemark)
    {
        map.removeAnnotations(map.annotations)
        FirstViewController.whatPinShow = -1
        displayPins()
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        annotation.subtitle = LocationSearchTable.parseAddress(placemark)
        me = false
        map.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        map.setRegion(region, animated: true)
    }
    
    

}

