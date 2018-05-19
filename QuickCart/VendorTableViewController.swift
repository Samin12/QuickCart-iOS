//
//  VendorTableViewController.swift
//  QuickCart
//
//  Created by Julie on 4/7/18.
//  Copyright © 2018 Julie. All rights reserved.
//

import UIKit
import GoogleMaps



public class Vendor {
    var name: String
    var image: UIImage
    var menu = [Food]()
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
    
    func addFood(newFood: Food){
        menu.append(newFood)
    }
}

public class Food{
    var name: String
    var image: UIImage
    var price :Float = 0.0
    
    init(name: String, image: UIImage, price: Float) {
        self.name = name
        self.image = image
        self.price = price
    }
}

class VendorTableViewController: UITableViewController, CLLocationManagerDelegate {
    //MARK: Properties
    
    @IBOutlet weak var mapView: GMSMapView!
    var vendors = [Vendor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        //placesClient = GMSPlacesClient.shared()
        
        
        let camera = GMSCameraPosition.camera(withLatitude: 40.728802, longitude: -73.995058, zoom: 15.0)
        mapView.camera = camera
        
        // Creates a marker in the center of the map.
        /*let marker0 = GMSMarker()
        marker0.position = CLLocationCoordinate2D(latitude: 40.728802, longitude: -73.995058)
        marker0.map = mapView
        */
        
        let position = CLLocationCoordinate2D(latitude: 40.728802, longitude: -73.995058)
        let userpos = GMSMarker(position: position)
        userpos.title = "User"
        userpos.icon = GMSMarker.markerImage(with: .blue)
        userpos.map = mapView
        
        let marker1 = GMSMarker()
        marker1.position = CLLocationCoordinate2D(latitude: 40.729318, longitude: -73.996163)
        marker1.title = "Nathans"
        marker1.snippet = "dogs"
        marker1.map = mapView
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: 40.728472, longitude: -73.995364)
        marker2.title = "Taco's Truck"
        marker2.snippet = "french fries only"
        marker2.map = mapView
        
        let marker3 = GMSMarker()
        marker3.position = CLLocationCoordinate2D(latitude: 40.731624, longitude: -73.994750)
        marker3.title = "Halal Guys"
        marker3.snippet = "nice meats"
        marker3.map = mapView
        
        let marker4 = GMSMarker()
        marker4.position = CLLocationCoordinate2D(latitude: 40.732200, longitude: -73.998612)
        marker4.title = "Food Place"
        marker4.snippet = "foods"
        marker4.map = mapView
        
        // Load the sample data.
        loadSampleVendors()

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vendors.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "VendorTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? VendorTableViewCell  else {
            fatalError("The dequeued cell is not an instance of VendorTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let vendor = vendors[indexPath.row]
        
        cell.nameLabel.text = vendor.name as String
        cell.photoImageView.image = vendor.image
        
        return cell

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier){
        case "showVendor"?:
            let vc = segue.destination as? VendorViewController
            let vendor = vendors[(tableView.indexPathForSelectedRow?.row)!]
            vc?.vendor = vendor
            break
        default:
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let bluecolor = UIColor(red: 82.0/255.0, green: 113.0/255.0, blue: 1, alpha: 1)
        
        self.navigationController?.navigationBar.barTintColor = bluecolor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }


    //MARK: Private Methods
    
    private func loadSampleVendors() {
        let photo1 = UIImage(named: "halalguys")
        let photo2 = UIImage(named: "nathans")
        let photo3 = UIImage(named: "gyro")
        let photo4 = UIImage(named: "hotdog")
        let photo5 = UIImage(named: "fries")
        let photo6 = UIImage(named: "tacotruck")
        let photo7 = UIImage(named: "burger")
        let photo8 = UIImage(named: "foodplace")

        
        let food1 = Food(name: "Gyro", image: photo3!, price: 8.99)
        let food2 = Food(name: "Hot Dog", image: photo4!, price: 4.99)
        let food3 = Food(name: "French Fries", image: photo5!, price: 2.99)
        let food4 = Food(name: "Burger", image: photo7!, price: 9.95)
        
        let vendor1 = Vendor(name: "Halal Guys", image: photo1!)
        vendor1.addFood(newFood: food1)
        vendor1.addFood(newFood: food2)
        vendor1.addFood(newFood: food3)
        vendor1.addFood(newFood: food4)

        
        let vendor2 = Vendor(name: "Nathan's", image: photo2!)
        vendor2.addFood(newFood: food2)
        vendor2.addFood(newFood: food3)
        
        let vendor3 = Vendor(name: "Taco's Truck", image: photo6!)
        vendor3.addFood(newFood: food3)
        
        let vendor4 = Vendor(name: "Food Place", image: photo8!)
        vendor4.addFood(newFood: food1)
        vendor4.addFood(newFood: food2)
        vendor4.addFood(newFood: food3)
        vendor4.addFood(newFood: food4)
        
        vendors += [vendor1, vendor2, vendor3, vendor4]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

}
