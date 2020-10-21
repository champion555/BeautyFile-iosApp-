//
//  BudgetTableViewCell.swift
//  BeatyFile(ios)
//
//  Created by Admin on 5/1/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class BudgetTableViewCell: UITableViewCell {
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lbMonth: UILabel!
    @IBOutlet weak var lbCategory: UILabel!
    @IBOutlet weak var lbBudget: UILabel!
    @IBOutlet weak var lbTotalBudget: UILabel!
    @IBOutlet weak var lbTotalMountTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        configureView()
        
    }
    func configureView(){
        viewCell.layer.borderColor = UIColor(red: 255/255.0, green: 111/255.0, blue: 169/255.0, alpha: 1).cgColor
        viewCell.layer.borderWidth = 1
        viewCell.layer.cornerRadius=5
        lbMonth.font = UIFont.boldSystemFont(ofSize: 18)
        lbTotalBudget.font = UIFont.boldSystemFont(ofSize: 14)
        lbTotalMountTitle.font = UIFont.boldSystemFont(ofSize: 14)
    }
 

}
