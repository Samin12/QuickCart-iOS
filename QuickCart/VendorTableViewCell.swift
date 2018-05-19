//
//  VendorTableViewCell.swift
//  QuickCart
//
//  Created by Julie on 4/7/18.
//  Copyright © 2018 Julie. All rights reserved.
//

import UIKit
import GoogleMaps


class VendorTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
