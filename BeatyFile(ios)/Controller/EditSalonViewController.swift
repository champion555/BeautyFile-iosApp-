//
//  EditSalonViewController.swift
//  BeatyFile(ios)
//
//  Created by Admin on 6/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Firebase
import KVNProgress

class EditSalonViewController: UIViewController {
    var currentData : SalonModel!
    var uuid = ""
    @IBOutlet var uiViews : [UIView]!
    @IBOutlet var uiButtons:[UIButton]!
    @IBOutlet weak var txtSalonName: UITextField!
    @IBOutlet weak var txtWebsite: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        displayCurrentData()

    }
    func configureView(){
        for viewItem in uiViews{
            viewItem.layer.borderWidth = 1
            viewItem.layer.borderColor = UIColor.white.cgColor
            viewItem.layer.cornerRadius = 5
        }
        for btItem in uiButtons{
            btItem.layer.cornerRadius = 5
        }
    }
    func displayCurrentData(){
        txtSalonName.text = currentData.salonName
        txtWebsite.text = currentData.website
        txtPhone.text = currentData.phone
        
    }

    @IBAction func OnSave(_ sender: Any) {
        let salonName = txtSalonName.text
        let website = txtWebsite.text
        let phone = txtPhone.text
        if salonName?.count == 0{
            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Please fill in the salon name")
            return
        }
        if website?.count == 0 {
            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Please fill in the website")
            return
        }
        if phone?.count == 0 {
            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Please fill in the phone number")
            return
        }
        guard  let userId = Auth.auth().currentUser?.uid else {return}
            let body = [
                "uuid": uuid,
                "salonName": salonName,
                "website": website,
                "phone": phone
            ]
        KVNProgress.show(withStatus: "Saving...", on:view)
           Firestore.firestore().collection("salon-data").document(userId).collection("data").document(uuid).setData(body as [String:Any]){
               error in
               if let error = error{
                   print("Error adding document: \(error)")
                   KVNProgress.showError(withStatus: error.localizedDescription)
               }else {
                   KVNProgress.dismiss()
                   GlobalData.salons = [SalonModel(dict:body as [String : Any])]
                   let vc = self.storyboard?.instantiateViewController(withIdentifier: "SalonsViewController") as! SalonsViewController
                   self.navigationController?.pushViewController(vc, animated: true)
                   
               }
           }
    }
    @IBAction func OnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
