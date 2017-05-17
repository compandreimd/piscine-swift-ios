//
//  LocationSearchTable.swift
//  test
//
//  Created by Admin on 30.04.17.
//  Copyright © 2017 Admintrst. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTable: UITableViewController, UISearchResultsUpdating
{
    
    var items = [MKMapItem]()
    var map: MKMapView?
    var handleMap: HandleMapSearch?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let selectedItem = items[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = LocationSearchTable.parseAddress(selectedItem)
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    func updateSearchResults(for searchController: UISearchController) {
            if (map != nil || searchController.searchBar.text != nil)
            {
                let text = searchController.searchBar.text!
                let req = MKLocalSearchRequest()
                req.naturalLanguageQuery = text
                req.region = map!.region
                let search = MKLocalSearch(request: req)
                search.start(completionHandler: {
                    res, _ in
                    if (res != nil)
                    {
                        self.items = res!.mapItems
                        self.tableView.reloadData()
                    }
                })
                
                
            }
    }
    
    static func parseAddress(_ selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.row].placemark
        handleMap?.dropPinZoomIn(selectedItem)
        dismiss(animated: true, completion: nil)
    }
}
