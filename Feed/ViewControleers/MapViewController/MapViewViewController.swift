//
//  MapViewViewController.swift
//  Feed
//
//  Created by Dimitar Spasovski on 4/11/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit



class MapViewViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    let annotation = MKPointAnnotation()
    
    var feedRealm = FeedRealm()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Setup Location
        let restaurantLocation = CLLocationCoordinate2D(latitude: (feedRealm.venueLat! as NSString).doubleValue, longitude:(feedRealm.vanueLong! as NSString).doubleValue)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta:0.05)
        let region = MKCoordinateRegion(center: restaurantLocation, span: span)
        mapView.setRegion(region, animated: true)
        annotation.coordinate = restaurantLocation
        annotation.title =  feedRealm.venueStreet
        annotation.subtitle = feedRealm.venueName
        mapView.addAnnotation(annotation)
        
        

        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismiss1))
        navigationItem.leftBarButtonItem = done

        
    }
    
    @objc func dismiss1(){
        self.dismiss(animated: true)
    }
    

}
