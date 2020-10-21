//
//  DetailTreatmentViewController.swift
//  BeatyFile(ios)
//
//  Created by Admin on 5/20/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Kingfisher

class DetailTreatmentViewController: UIViewController {
    var detailData : TreatmentModel!
    @IBOutlet var uiViews : [UIView]!
    @IBOutlet weak var lbInputDate: UILabel!
    @IBOutlet weak var lbCategory: UILabel!
    @IBOutlet weak var lbPractitionerName: UILabel!
    @IBOutlet weak var lbSalonName: UILabel!
    @IBOutlet weak var lbPhoneNumber: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbCost: UILabel!
    @IBOutlet weak var lbComment: UILabel!
    @IBOutlet weak var imgBeforePhoto: UIImageView!
    @IBOutlet weak var imgAfterPhoto: UIImageView!
    @IBOutlet weak var imgReceipt: UIImageView!
    @IBOutlet weak var imgAdayAfter: UIImageView!
    @IBOutlet weak var imgAweekAfter: UIImageView!
    @IBOutlet weak var imgAmonthAfter: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        displayData()
    }
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func configureView(){
        imgBeforePhoto.layer.cornerRadius = 10
        imgAfterPhoto.layer.cornerRadius = 10
        imgReceipt.layer.cornerRadius = 10
        imgAdayAfter.layer.cornerRadius = 10
        imgAweekAfter.layer.cornerRadius = 10
        imgAmonthAfter.layer.cornerRadius = 10
        
        for viewItem in uiViews{
            viewItem.layer.borderWidth = 1
            viewItem.layer.cornerRadius=5
            viewItem.layer.borderColor = UIColor.white.cgColor
        }
    }
    func displayData(){
        lbInputDate.text = detailData.inputDate
        lbCategory.text = detailData.category
        lbPractitionerName.text = detailData.practitionerName
        lbSalonName.text = detailData.salonName
        lbPhoneNumber.text = detailData.salonPhoneNum
        lbEmail.text = detailData.salonEmail
        lbDescription.text = detailData.treatmentDescription
        lbCost.text = detailData.cost
        lbComment.text = detailData.comment
        
        imgBeforePhoto.kf.setImage(with: URL(string: detailData.beforePhoto), placeholder: nil, options: nil)
        imgAfterPhoto.kf.setImage(with: URL(string: detailData.afterPhoto), placeholder: nil, options: nil)
        imgReceipt.kf.setImage(with: URL(string: detailData.receiptPhoto), placeholder: nil, options: nil)
        imgAdayAfter.kf.setImage(with: URL(string: detailData.aDayAfterPhoto), placeholder: nil, options: nil)
        imgAweekAfter.kf.setImage(with: URL(string: detailData.aWeekAfterPhoto), placeholder: nil, options: nil)
        imgAmonthAfter.kf.setImage(with: URL(string: detailData.aMonthAfterPhoto), placeholder: nil, options: nil)
        
    }
 

}
