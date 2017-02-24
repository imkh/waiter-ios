//
//  MapViewController.swift
//  Waiter
//

import Foundation
import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    
    var long: Double = 0.0;
    
    var lat: Double = 0.0;
    
    var marker: GMSMarker!;
    var mapView: GMSMapView!;
    var firstTimeCamera = false;
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0]
        
        if (lat != userLocation.coordinate.latitude || long != userLocation.coordinate.longitude) {
            long = userLocation.coordinate.longitude;
            lat = userLocation.coordinate.latitude;
            if (mapView != nil && marker != nil) {
                //            let camera = GMSCameraPosition.cameraWithLatitude(lat,
                //                                                              longitude: long, zoom: 17)
                //            mapView.camera = camera;
                marker.position = CLLocationCoordinate2DMake(lat, long);
            }
            if (mapView != nil && firstTimeCamera == false) {
                let camera = GMSCameraPosition.cameraWithLatitude(lat,
                                                                  longitude: long, zoom: 13)
                mapView.camera = camera;
                firstTimeCamera = true;
                print(lat, long);
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad();
        
        locationManager = CLLocationManager();
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
//            mapView.showsUserLocation = true
        }

        let camera = GMSCameraPosition.cameraWithLatitude(lat,
                                                          longitude: long, zoom: 13)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        self.view = mapView
        
        marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(lat, long);
        marker.title = "Me"
        marker.snippet = "Epitech"
        marker.map = mapView
        print("google map loaded")
    }
}
