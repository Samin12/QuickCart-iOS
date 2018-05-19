//
//  VendorViewController.swift
//  QuickCart
//
//  Created by Julie on 4/7/18.
//  Copyright © 2018 Julie. All rights reserved.
//
//API key: AIzaSyCodmzI7oYNo5gGJ0YzEeFX96w9qIQBcIc

import UIKit

class VendorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    var vendor:Vendor?
    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var vendorImageView: UIImageView!
    @IBOutlet weak var vendorItemsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if vendor != nil{
            self.vendorNameLabel.text = vendor?.name
            //vendor?.image.size = self.vendorImageView.image?.size
            self.vendorImageView.image = vendor?.image
            //self.vendorImageView.mask
        }
        vendorItemsTableView.delegate = self
        vendorItemsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let bluecolor = UIColor(red: 82.0/255.0, green: 113.0/255.0, blue: 1, alpha: 1)
        
        self.navigationController?.navigationBar.barTintColor = bluecolor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vendor!.menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell") as! FoodTableViewCell
        cell.nameLabel.text = vendor?.menu[indexPath.row].name
        cell.foodLabel.text = String(format: "%.2f", (vendor?.menu[indexPath.row].price)!)
        cell.photoImageView?.image = vendor?.menu[indexPath.row].image
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ShoppingCart.items.append((vendor?.menu[indexPath.row])!)
        let sVC:ShoppingCartViewController = self.storyboard?.instantiateViewController(withIdentifier: "shoppingCartVC") as! ShoppingCartViewController
        self.present(sVC, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

