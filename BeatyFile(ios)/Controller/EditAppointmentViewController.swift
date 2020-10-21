//
//  EditAppointmentViewController.swift
//  BeatyFile(ios)
//
//  Created by Admin on 6/8/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Firebase
import KVNProgress
import DatePickerDialog

class EditAppointmentViewController: UIViewController {
    var editData:AppointmentsModel!
    var documentID = ""
    @IBOutlet var uiViews : [UIView]!
    @IBOutlet var uiButtons : [UIButton]!
    @IBOutlet weak var btSave: UIButton!
    @IBOutlet weak var btCancel: UIButton!
    @IBOutlet weak var lbDate: UITextField!
    @IBOutlet weak var lbSalon: UITextField!
    @IBOutlet weak var lbTreatment: UITextField!
    @IBOutlet weak var lbWebsite: UITextField!
    @IBOutlet weak var lbPhone: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        displayCurrentData()
        lbDate.delegate = self
    }
    func configureView(){
        lbDate.tag = 100
        for viewItem in uiViews{
            viewItem.layer.cornerRadius = 5
        }
        for btItem in uiButtons{
            btItem.layer.cornerRadius = 5
        }
    }
    func displayCurrentData(){
        lbDate.text = editData.appoinmentDate
        lbSalon.text = editData.salonName
        lbTreatment.text = editData.treatment
        lbWebsite.text = editData.website
        lbPhone.text = editData.phone
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
                formatter.dateFormat = "eeee, hh:mm a, dd/MMMM/yyyy"
                self.lbDate.text = formatter.string(from: dt)
            }
        }
    }

    @IBAction func OnSave(_ sender: Any) {
        let appointmentDate = lbDate.text
        let salonName = lbSalon.text
        let treatment = lbTreatment.text
        let phone = lbPhone.text
        let webstie = lbWebsite.text
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
        }else{
            guard  let userId = Auth.auth().currentUser?.uid else {return}
            let body = [
                "appoinmentDate": appointmentDate,
                "salonName": salonName,
                "treatment": treatment,
                "website":webstie,
                "phone":phone
            ]
            KVNProgress.show(withStatus: "Saving...", on:view)
            Firestore.firestore().collection("appointment-data").document(userId).collection("data").document(self.documentID).setData(body as [String:Any]){
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
    @IBAction func OnCancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
extension EditAppointmentViewController: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 100{
            InputdatePickerTapped()
            return false
        }
        return true
    }
}
