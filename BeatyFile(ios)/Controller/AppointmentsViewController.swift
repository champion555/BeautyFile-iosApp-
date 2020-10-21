//
//  AppointmentsViewController.swift
//  BeatyFile(ios)
//
//  Created by Admin on 4/29/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Firebase
import KVNProgress


class AppointmentsViewController: UIViewController {

    @IBOutlet weak var tableAppointment: UITableView!
    var appointmentsData:[AppointmentsModel] = []
    var appointmentID:[String] = []
    var appointmentsInfo:[AppointmentsModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getAppointmentData()
    }
    func getAppointmentData(){
        KVNProgress.show()
        guard let userId = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("appointment-data").document(userId).collection("data").getDocuments() { (docs, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }else {
                    KVNProgress.dismiss()
                    print(docs?.documents as Any)
                    GlobalData.appointments = []
                    for document in docs!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let con = AppointmentsModel(dict: document.data())
                        self.appointmentsData.append(con)
                        self.appointmentID.append(document.documentID)
                        GlobalData.appointments.append(con)
                    }
                    self.appointmentsInfo = self.appointmentsData
                    self.tableAppointment.reloadData()
                }
        }
    }
    @IBAction func OnAddAppoinment(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddAppointmentViewController") as! AddAppointmentViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
extension AppointmentsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return appointmentsInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentTableViewCell", for: indexPath) as! AppointmentTableViewCell
        let appointment = GlobalData.appointments[indexPath.row]
        let fullDate = appointment.appoinmentDate
        let fullDateArr = fullDate.split(separator: ",")
        //remove space from string
        let cleanString = fullDateArr[1].trimmingCharacters(in: .whitespacesAndNewlines)
        
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor.white
        
        cell.lbTreatment.text = appointment.treatment
        cell.lbDate.text = String(fullDateArr[0]+fullDateArr[2])
        cell.lbTime.text = cleanString
        cell.lbSalonName.text = appointment.salonName
        cell.lbPhone.text = appointment.phone
        cell.lbWebsite.text = appointment.website
        
        return cell
    }
}
extension AppointmentsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

           return true
       }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let editBt = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            print("edit Button tapped")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditAppointmentViewController") as! EditAppointmentViewController
            vc.editData = self.appointmentsData[indexPath.row]
            vc.documentID = self.appointmentID[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        editBt.backgroundColor = UIColor.orange

        let deleteBt = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
        print("Delete button tapped")
        let alertController = UIAlertController(title: "Alert", message: "Are you sure you want to delete this?", preferredStyle: .alert)
                let showAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    //Delete the cell's images from storage
                    let udid = self.appointmentID[indexPath.row]
                    let user = Auth.auth().currentUser
                    KVNProgress.show()
                    Firestore.firestore().collection("appointment-data").document((user?.uid)!).collection("data").document(udid).delete { (err) in
                        if let error = err {
                            print(error.localizedDescription)
                        }else {
                            KVNProgress.dismiss()
                            self.appointmentsInfo.remove(at: indexPath.row)
                            self.tableAppointment.reloadData()
                        }
                    }
                }
            let removeAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
            alertController.addAction(showAction)
            alertController.addAction(removeAction)
            self.present(alertController, animated: true, completion: nil)

        }
        deleteBt.backgroundColor = UIColor(red: 238/255.0, green: 39/255.0, blue: 130/255.0, alpha: 1)
        return [deleteBt, editBt]
    }
}

