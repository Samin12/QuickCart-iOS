//
//  MapViewController.swift
//  QuickCart
//
//  Created by Samin isalm on 4/23/18.
//  Copyright © 2018 Julie. All rights reserved.
//

import UIKit
import GoogleMaps
class MapView: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
                let camera = GMSCameraPosition.camera(withLatitude: 40.728802, longitude: -73.995058, zoom: 15.0)
                let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
                view = mapView
        
                // Creates a marker in the center of the map.
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: 40.728802, longitude: -73.995058)
                marker.map = mapView
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
