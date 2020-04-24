//
//  LocationSearchViewController.swift
//  Final Project
//
//  Created by 张泽华 on 2020/4/25.
//  Copyright © 2020 张泽华. All rights reserved.
//

import UIKit
import MapKit
class LocationSearchViewController: UIViewController {
    
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    var handleMapSearchDelegate:HandleMapSearch? = nil
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            selectedItem.thoroughfare ?? "",
            comma,
            selectedItem.locality ?? "",
            secondSpace,
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
}

extension LocationSearchViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text
            else {
                    return
        }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}

extension LocationSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        dismiss(animated: true, completion: nil)
    }
}



