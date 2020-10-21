//
//  TreatmentTableViewCell.swift
//  BeatyFile(ios)
//
//  Created by Admin on 4/30/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol TreatmentTableViewCellDelegate {
    func didCategoryLabelTap(index:Int)
//    func didSalonLabelTap(index:Int)
}

class TreatmentTableViewCell: UITableViewCell {
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbCategorie: UILabel!
    @IBOutlet weak var lbBudget: UILabel!
    @IBOutlet weak var imgAvata: UIImageView!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbPractitioner: UILabel!    
    @IBOutlet weak var viewCell: UIView!
    var delegate:TreatmentTableViewCellDelegate?
    var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapCategoty = UITapGestureRecognizer(target: self, action: #selector(TreatmentTableViewCell.onLbCategory))
        lbCategorie.isUserInteractionEnabled = true
        lbCategorie.addGestureRecognizer(tapCategoty)
        configureView()
        
//        let tapSalonName = UITapGestureRecognizer(target: self, action: #selector(TreatmentTableViewCell.onSalonName))
//        lbPractitioner.isUserInteractionEnabled = true
//        lbPractitioner.addGestureRecognizer(tapSalonName)
//        configureView()
    }
    func configureView(){
        viewCell.layer.borderColor = UIColor(red: 238/255.0, green: 39/255.0, blue: 130/255.0, alpha: 1).cgColor
        viewCell.layer.borderWidth = 1
        viewCell.layer.cornerRadius=5
        lbCategorie.font = UIFont.boldSystemFont(ofSize: 18)       
    }
    @objc func onLbCategory(sender:UITapGestureRecognizer) {
        delegate?.didCategoryLabelTap(index:index!.row)
        
    }
//    @objc func onSalonName(sender:UITapGestureRecognizer) {
//        delegate?.didSalonLabelTap(index:index!.row)
//
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

