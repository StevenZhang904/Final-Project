//
//  MapViewController.swift
//  Final Project
//
//  Created by 张泽华 on 2020/4/22.
//  Copyright © 2020 张泽华. All rights reserved.
//

import UIKit
import MapKit
protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}


class MapViewController: UIViewController {
 
    var selectedPin:MKPlacemark? = nil
    let regionDistance: CLLocationDistance = 750

    @IBOutlet weak var mapView: MKMapView!
    var resultSearchController:UISearchController? = nil
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self

    }
    
}

extension MapViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            mapView.setRegion(region, animated: true)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:\(error.localizedDescription)")
    }
}

extension MapViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        selectedPin = placemark
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
        let state = placemark.administrativeArea {
            annotation.subtitle = "(city) (state)"
        }
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: placemark.coordinate, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        mapView.setRegion(region, animated: true)
    }
}
