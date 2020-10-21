//
//  SalonDetailTableViewCell.swift
//  BeatyFile(ios)
//
//  Created by Admin on 6/3/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class SalonDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbCategory: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbCost: UILabel!
    @IBOutlet weak var lbPractitioner: UILabel!
    @IBOutlet weak var lbSalon: UILabel!
    @IBOutlet weak var lbWebsite: UILabel!
    @IBOutlet weak var viewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    func configureView(){
        viewCell.layer.borderColor = UIColor(red: 255/255.0, green: 111/255.0, blue: 169/255.0, alpha: 1).cgColor
        viewCell.layer.borderWidth = 1
        viewCell.layer.cornerRadius=5
        lbCategory.font = UIFont.boldSystemFont(ofSize: 18)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
