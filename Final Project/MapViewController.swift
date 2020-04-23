//
//  MapViewController.swift
//  Final Project
//
//  Created by 张泽华 on 2020/4/22.
//  Copyright © 2020 张泽华. All rights reserved.
//

import UIKit
import MapKit
import GooglePlaces
class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let regionDistance: CLLocationDistance = 750
    override func viewDidLoad() {
        super.viewDidLoad()
        //mapView.delegate = self
        let region = MKCoordinateRegion(center: <#T##CLLocationCoordinate2D#>, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        mapView.setRegion(region, animated: true)
    }
    
}

extension MapViewController: CLLocationManagerDelegate{
    func getLocation() {
        //locationManager = CLLocationManager()
        //locationManager.delegate = self
    }
}
