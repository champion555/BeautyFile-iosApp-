//
//  EditTreatmentViewController.swift
//  BeatyFile(ios)
//
//  Created by Admin on 5/21/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import DatePickerDialog
import KVNProgress
import Firebase
import Kingfisher

class EditTreatmentViewController: UIViewController{
    var editData : TreatmentModel!
    var documentID = ""
    @IBOutlet var uiViews : [UIView]!
    @IBOutlet var uiButtons:[UIButton]!
    @IBOutlet var uiImageViews: [UIImageView]!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var txtDatePicker: UITextField!
    @IBOutlet weak var dropdata: DropDown!
    @IBOutlet weak var txtPractitionerName: UITextField!
    @IBOutlet weak var txtSalonName: UITextField!
    @IBOutlet weak var txtSanlonPhoneNumber: UITextField!
    @IBOutlet weak var txtSalonEmail: UITextField!
    @IBOutlet weak var txtTreatmentDescription: UITextView!
    @IBOutlet weak var txtCost: UITextField!
    @IBOutlet weak var txtComments: UITextView!
    
    var imagePicker: ImagePicker!
    var tag_view = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        displayCurrentData()
        txtDatePicker.delegate = self
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        dropDownInit()
    }
    func displayCurrentData(){
        txtDatePicker.text = editData.inputDate
        dropdata.text = editData.category
        txtPractitionerName.text = editData.practitionerName
        txtSalonName.text = editData.salonName
        txtSanlonPhoneNumber.text = editData.salonPhoneNum
        txtSalonEmail.text = editData.salonEmail
        txtTreatmentDescription.text = editData.treatmentDescription
        txtCost.text = editData.cost
        txtComments.text = editData.comment
        
        for image in uiImageViews{
            switch image.tag{
                case 11:
                    image.kf.setImage(with: URL(string: editData.beforePhoto), placeholder: nil, options: nil)
                    break
                case 12:
                    image.kf.setImage(with: URL(string: editData.afterPhoto), placeholder: nil, options: nil)
                    break
                case 13:
                    image.kf.setImage(with: URL(string: editData.receiptPhoto), placeholder: nil, options: nil)
                    break
                case 14:
                    image.kf.setImage(with: URL(string: editData.aDayAfterPhoto), placeholder: nil, options: nil)
                    break
                case 15:
                    image.kf.setImage(with: URL(string: editData.aWeekAfterPhoto), placeholder: nil, options: nil)
                    break
                case 16:
                    image.kf.setImage(with: URL(string: editData.aMonthAfterPhoto), placeholder: nil, options: nil)
                    break
                default:
                    break
            }
        }
        
    }
        
    
    func dropDownInit(){
        dropdata.optionArray = ["Anti-wrinkle Injections","BB Glow","Body Shaping","Brows","Dental","Dermal Fillers","Dermaplaning","Facials","Hairdressing","Hair Removal","Lasers","Lashes","LED Light Therapy","Makeup","Microdermabrasion","Nails","Plasma Therapy","PRP","Radio Frequency","Skin Boosters","Skin Needling","Skin Peels","Skin Rejuvanation","Skin Resurfacing","Skin Tightening","Tanning","Tattoos","Thread Lifts","Other..."]
//        dropdata.selectValue(index: 0)
        dropdata.didSelect(completion: {selectedText, index, id in
        print(selectedText, index, id)
        let date = selectedText.lowercased()
        print("date:\(date)")
        })
        dropdata.delegate = self
    }
    //initialize UIComponents
    func configureView(){
        txtDatePicker.tag = 100
        dropdata.tag = 300
        btnSave.layer.cornerRadius=5
        btnCancel.layer.cornerRadius=5
        for viewItem in uiViews{
            viewItem.layer.borderWidth = 1
            viewItem.layer.cornerRadius=5
            viewItem.layer.borderColor = UIColor.white.cgColor
        }
        for imageItem in uiImageViews{
            imageItem.layer.cornerRadius=10
        }
    }
    //when tapped, InputDatepicker
    func InputdatePickerTapped() {
        let datePicker = DatePickerDialog(
           textColor: .red,
           buttonColor: .red,
           font: UIFont.boldSystemFont(ofSize: 17),
           showCancelButton: true
        )
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.month = +3
        let threeMonthAfter = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        datePicker.show("Select Date",
                        doneButtonTitle: "Done",
                        cancelButtonTitle: "Cancel",
                        minimumDate: threeMonthAfter,
                        maximumDate: currentDate,
                        datePickerMode: .date) { (date) in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd MMMM yyyy"
                self.txtDatePicker.text = formatter.string(from: dt)
                
            }
        }
    }
    @IBAction func didPreeImageView(_ sender: UIButton){
           switch sender.tag{
               case 1:
                   self.imagePicker.present(from: sender)
                   self.tag_view = 1
               break
               case 2:
                   self.imagePicker.present(from: sender)
                   self.tag_view = 2
               break
               case 3:
                   self.imagePicker.present(from: sender)
                   self.tag_view = 3
               break
               case 4:
                   self.imagePicker.present(from: sender)
                   self.tag_view = 4
               break
               case 5:
                   self.imagePicker.present(from: sender)
                   self.tag_view = 5
               break
               case 6:
                   self.imagePicker.present(from: sender)
                   self.tag_view = 6
               break
           default:
               break
           }
       }
    @IBAction func OnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func OnCancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func OnSave(_ sender: Any) {
        let timestamp = NSDate().timeIntervalSince1970
        let time = Int(timestamp)
        let inputDate = txtDatePicker.text!
        let category = dropdata.text
        let practitionerName = txtPractitionerName.text!
        let salonName = txtSalonName.text!
        let salonPhoneNumber = txtSanlonPhoneNumber.text!
        let salonEmail = txtSalonEmail.text!
        let treatmentDescription = txtTreatmentDescription.text!
        var cost = txtCost.text!
        let comment = txtComments.text!
        let beforePhoto = uiImageViews[0].image
        let afterPhoto = uiImageViews[1].image
        let receiptPhoto = uiImageViews[2].image
        let aDayAfterPhoto = uiImageViews[3].image
        let aWeekAfterPhoto = uiImageViews[4].image
        let aMonthAfterPhoto = uiImageViews[5].image
        let images = [beforePhoto, afterPhoto, receiptPhoto, aDayAfterPhoto,aWeekAfterPhoto,aMonthAfterPhoto]
        var count = 0
        var selectedImage: Data!
        var imageURLs: [Int:String] = [:]
        if inputDate.count == 0{
            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Please select Date")
            return
        }
        if category?.count == 0 {
            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Please select category")
            return
        }
        if practitionerName.count == 0 {
            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Please fill in the practitioner's name")
            return
        }
        if salonName.count == 0 {
            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Please fill in the salon name")
            return
        }
        if salonPhoneNumber.count == 0{
            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Please fill in the salon phone number")
            return
        }
//        if salonEmail.count == 0{
//            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Please fill in the salonEmail")
//            return
//        }else if !CommonManager.shared.isValidEmail(testStr: salonEmail) {
//            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Invalid Email")
//            return
//        }
//        if treatmentDescription.count == 0{
//            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Please fill in the treatment description")
//            return
//        }
        if cost.count == 0 {
           cost = "0"
        }
//        if comment.count == 0 {
//            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Please fill in the comment")
//            return
//        }
//        if uiImageViews.isEmpty{
//            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "please take the photo")
//        }
        KVNProgress.show(withStatus: "Saving...", on: view)
        guard let userId = Auth.auth().currentUser?.uid else {return}
        for i in 0..<images.count{
            if images[i] == nil{
                count += 1
                imageURLs[i] = ""
                if count == 6 {
                    let body = [
                            "timestamp": time,
                            "uuid":documentID,
                            "uid": userId,
                            "inputDate": inputDate,
                            "category": category as Any,
                            "practitionerName": practitionerName,
                            "salonName": salonName,
                            "salonPhoneNum": salonPhoneNumber,
                            "salonEmail": salonEmail,
                            "treatmentDescription":treatmentDescription,
                            "cost" :cost,
                            "comment": comment,
                            "beforePhoto":imageURLs[0]!,
                            "afterPhoto": imageURLs[1]!,
                            "receiptPhoto": imageURLs[2]!,
                            "aDayAfterPhoto": imageURLs[3]!,
                            "aWeekAfterPhoto": imageURLs[4]!,
                            "aMonthAfterPhoto": imageURLs[5]!
                    ] as [String : Any]
                    Firestore.firestore().collection("treatment-data").document(userId).collection("category").document(self.documentID).setData(body as [String : Any]) {
                            error in
                            if let error = error {
                                print("Error adding document: \(error)")
                                KVNProgress.showError(withStatus: error.localizedDescription)
                            } else {
                                KVNProgress.dismiss()
                                GlobalData.treatments = [TreatmentModel(dict: body)]
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TreatmentsViewController") as! TreatmentsViewController
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                }
                
            }else{
                selectedImage = images[i]!.jpegData(compressionQuality: 0.7)
                let uuid = UUID().uuidString
                let ref = Storage.storage().reference(withPath: "treatment-data").child(userId).child(uuid + ".jpg")
                    ref.putData(selectedImage, metadata: nil) { (metadata, error) in
                            if error == nil {
                                ref.downloadURL(completion: {
                                    url, error in
                                    guard error != nil else {
                                        imageURLs[i] = url!.absoluteString
                                            count+=1
                                            if count == 6{
                                                let body = [
                                                        "timestamp": time,
                                                        "uuid":self.documentID,
                                                        "uid": userId,
                                                        "inputDate": inputDate,
                                                        "category": category as Any,
                                                        "practitionerName": practitionerName,
                                                        "salonName": salonName,
                                                        "salonPhoneNum": salonPhoneNumber,
                                                        "salonEmail": salonEmail,
                                                        "treatmentDescription":treatmentDescription,
                                                        "cost" :cost,
                                                        "comment": comment,
                                                        "beforePhoto":imageURLs[0]!,
                                                        "afterPhoto": imageURLs[1]!,
                                                        "receiptPhoto": imageURLs[2]!,
                                                        "aDayAfterPhoto": imageURLs[3]!,
                                                        "aWeekAfterPhoto": imageURLs[4]!,
                                                        "aMonthAfterPhoto": imageURLs[5]!
                                                        ] as [String : Any]
                                                Firestore.firestore().collection("treatment-data").document(userId).collection("category").document(self.documentID).setData(body as [String : Any]){
                                                    error in
                                                    if let error = error {
                                                        print("Error adding document: \(error)")
                                                        KVNProgress.showError(withStatus: error.localizedDescription)
                                                    } else {
                                                        KVNProgress.dismiss()
                                                        GlobalData.treatments = [TreatmentModel(dict: body)]
                                                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TreatmentsViewController") as! TreatmentsViewController
                                                        self.navigationController?.pushViewController(vc, animated: true)
                                                    }
                                                   
                                                }
                                            }
                                        return
                                    }
                                    
                                })
                            } else {
                                KVNProgress.showError(withStatus: error!.localizedDescription, on: self.view)
                            }
                }
                
            }
            

        }
    }
    

}
extension EditTreatmentViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
       // if txtDatePicker = txtDatePicker
        if textField.tag == 100 {
            InputdatePickerTapped()
            return false
        }
        if textField.tag == 300 {
            dropdata.isSelected ? dropdata.hideList(): dropdata.showList()
            return false
        }
        return true
    }

}
extension EditTreatmentViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        
        switch self.tag_view {
        case 1:
            if let imgView = self.view.viewWithTag(11) as? UIImageView {
                imgView.image = image
            }
            break
        case 2:
            if let imgView = self.view.viewWithTag(12) as? UIImageView {
                imgView.image = image
            }
            break
        case 3:
            if let imgView = self.view.viewWithTag(13) as? UIImageView {
                imgView.image = image
            }
            break
        case 4:
            if let imgView = self.view.viewWithTag(14) as? UIImageView {
                imgView.image = image
            }
            break
        case 5:
            if let imgView = self.view.viewWithTag(15) as? UIImageView {
                imgView.image = image
            }
            break
        case 6:
            if let imgView = self.view.viewWithTag(16) as? UIImageView {
                imgView.image = image
            }
            break
        default:
            
            break
        }
      
    }
}
