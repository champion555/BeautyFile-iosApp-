//
//  AddAppointmentViewController.swift
//  BeatyFile(ios)
//
//  Created by Admin on 5/1/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Firebase
import KVNProgress
import DatePickerDialog

class AddAppointmentViewController: UIViewController{
    @IBOutlet var uiViews : [UIView]!
    @IBOutlet var uiButtons : [UIButton]!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtSalonName: UITextField!
    @IBOutlet weak var txtTreatment: UITextField!
    @IBOutlet weak var txtWebsite: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        txtDate.delegate = self
    }
  
    func configureView(){
        txtDate.tag = 100
        for viewItem in uiViews{
            viewItem.layer.borderWidth = 1
            viewItem.layer.cornerRadius=5
            viewItem.layer.borderColor = UIColor.white.cgColor
        }
        for viewButton in uiButtons{
            viewButton.layer.cornerRadius = 5
        }
    }
    func InputdatePickerTapped() {
        let datePicker = DatePickerDialog(
           textColor: .red,
           buttonColor: .red,
           font: UIFont.boldSystemFont(ofSize: 17),
           showCancelButton: true
        )
        datePicker.show("Select date and time",
                doneButtonTitle: "Done",
                cancelButtonTitle: "Cancel",
                datePickerMode: .dateAndTime) { (date) in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "eeee, hh:mm a, dd MMMM yyyy"
                self.txtDate.text = formatter.string(from: dt)
            }
        }
    }
    
    @IBAction func OnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func OnCancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func OnSave(_ sender: Any) {
        let appointmentDate = txtDate.text
        let salonName = txtSalonName.text
        let treatment = txtTreatment.text
        let website = txtWebsite.text
        let phone = txtPhone.text
    
        
        if appointmentDate?.count == 0{
            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Please select Appointment Date")
            return
        }
        if salonName?.count == 0 {
            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Please fill in the salon name")
            return
        }
        if phone?.count == 0 {
            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Please fill in the phone number")
            return
        }
        if treatment?.count == 0 {
            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Please fill in the treatment")
            return
        } else {
            guard  let userId = Auth.auth().currentUser?.uid else {return}
        
            let body = [
                "appoinmentDate": appointmentDate,
                "salonName": salonName,
                "treatment": treatment,
                "website":website,
                "phone":phone
            ]
            KVNProgress.show(withStatus: "Saving...", on:view)
            Firestore.firestore().collection("appointment-data").document(userId).collection("data").document().setData(body as [String:Any]){
                error in
                if let error = error{
                    print("Error adding document: \(error)")
                    KVNProgress.showError(withStatus: error.localizedDescription)
                }else {
                    KVNProgress.dismiss()
                    GlobalData.appointments = [AppointmentsModel(dict:body as [String : Any])]
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppointmentsViewController") as! AppointmentsViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
            }
        }
        
    }
    
}
extension AddAppointmentViewController: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 100{
            InputdatePickerTapped()
            return false
        }
        return true
    }
}
