//
//  SalonTableViewCell.swift
//  BeatyFile(ios)
//
//  Created by Admin on 5/1/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol SalonTableViewCellDelegate {
    func didSalonLabelTap1(index:Int)
}

class SalonTableViewCell: UITableViewCell {
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lbSalonName: UILabel!
    @IBOutlet weak var lbSalonPhonNumber: UILabel!
    @IBOutlet weak var lbSalonEmail: UILabel!
    @IBOutlet weak var lbSalonNameTitle: UILabel!
    var delegate:SalonTableViewCellDelegate?
    var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
        
        let tapSalon = UITapGestureRecognizer(target: self, action: #selector(SalonTableViewCell.onLbSalonName1))
        lbSalonName.isUserInteractionEnabled = true
        lbSalonName.addGestureRecognizer(tapSalon)
    }
    func configureView(){
        viewCell.layer.borderColor = UIColor(red: 255/255.0, green: 111/255.0, blue: 169/255.0, alpha: 1).cgColor
        viewCell.layer.borderWidth = 1
        viewCell.layer.cornerRadius=5
        lbSalonName.font = UIFont.boldSystemFont(ofSize: 18)
    }
    @objc func onLbSalonName1(sender:UITapGestureRecognizer) {
        delegate?.didSalonLabelTap1(index:index!.row)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
