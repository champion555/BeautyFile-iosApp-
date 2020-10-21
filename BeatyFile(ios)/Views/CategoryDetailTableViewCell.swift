//
//  CategoryDetailTableViewCell.swift
//  BeatyFile(ios)
//
//  Created by Admin on 6/3/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class CategoryDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var lbSalon: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbPractitioner: UILabel!
    @IBOutlet weak var lbCost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    func configureView(){
        ContentView.layer.borderColor = UIColor(red: 255/255.0, green: 111/255.0, blue: 169/255.0, alpha: 1).cgColor
        ContentView.layer.borderWidth = 1
        ContentView.layer.cornerRadius=5
        lbSalon.font = UIFont.boldSystemFont(ofSize: 18)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
