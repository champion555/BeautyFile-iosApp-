//
//  CategoryTableViewCell.swift
//  BeatyFile(ios)
//
//  Created by Admin on 5/20/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var lbCategory: UILabel!
    @IBOutlet weak var lbCategoryArr: UILabel!
    @IBOutlet weak var uiView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    func configureView(){
        uiView.layer.borderColor = UIColor(red: 255/255.0, green: 111/255.0, blue: 169/255.0, alpha: 1).cgColor
        uiView.layer.borderWidth = 1
        uiView.layer.cornerRadius=5
        lbCategory.font = UIFont.boldSystemFont(ofSize: 18)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
