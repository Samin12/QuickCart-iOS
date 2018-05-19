//
//  ShoppingCartViewController.swift
//  QuickCart
//
//  Created by Samin on 4/24/18.
//  Copyright © 2018 Samin. All rights reserved.
//

import UIKit
import Foundation
//if it saysalamo fire not found please put the alamo fire folder inside the quickcart folder, 
import Alamofire
import AVFoundation


class ShoppingCartViewController:


    UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    var musicEffect : AVAudioPlayer = AVAudioPlayer()

    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var shoppingCartTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShoppingCart.items.count
    }
    
    
    
    @IBAction func sendText(_ sender: Any) {
        
        //sound
        
        
        let musicFile = Bundle.main.path(forResource: "Rock", ofType: ".mp3")
        
        do{
            try musicEffect = AVAudioPlayer(contentsOf: URL (fileURLWithPath: musicFile!))
        }
        catch{
            print(error)
        }
        
        musicEffect.play()
        var stringSend = "Incomming order of "
        
        //totalLabel.te
        for Food in ShoppingCart.items {
            stringSend+=Food.name+", "
        }
        
        stringSend+=" And the total is: "+totalLabel.text!
        
        print(stringSend)
        
        let url = "https://api.twilio.com/2010-04-01/Accounts/ACf1cfc2cf9bab2c9e3939e6bfbf518f71/Messages"
        let parameters = ["From": "6468636486", "To": "3477612839", "Body": stringSend] as [String : Any]
        
    
    
        
        
        Alamofire.request(url, method: .post, parameters: parameters)
            .authenticate(user: "ACf1cfc2cf9bab2c9e3939e6bfbf518f71", password: "ec9e25df6028ab386bec76e96a5efc0d")
            .responseJSON { response in
                debugPrint(response)
        }
    
        RunLoop.main.run()

        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell") as! FoodTableViewCell
        //let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        //cell.textLabel?.text = ShoppingCart.items[indexPath.row].name
        
        cell.nameLabel.text = "\(ShoppingCart.items[indexPath.row].name)"
        
        cell.foodLabel.text = "$\(ShoppingCart.items[indexPath.row].price)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { action, index in
            //print("more button tapped")
            ShoppingCart.items.remove(at: indexPath.row)
            self.shoppingCartTableView.reloadData()
            
            ShoppingCart.totalCost = 0
            for food in ShoppingCart.items {
                ShoppingCart.totalCost += food.price
            }
            
            self.totalLabel.text = String(format: "%.2f", ShoppingCart.totalCost)
            
            //reload
        }
        
        return [delete]
    }
    
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shoppingCartTableView.delegate = self
        shoppingCartTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        for food in ShoppingCart.items {
            ShoppingCart.totalCost += food.price
        }
        
        totalLabel.text = String(format: "%.2f", ShoppingCart.totalCost)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
