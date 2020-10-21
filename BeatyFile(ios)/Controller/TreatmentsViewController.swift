//
//  TreatmentsViewController.swift
//  BeatyFile(ios)
//
//  Created by Admin on 4/29/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Firebase
import KVNProgress
import Kingfisher

class TreatmentsViewController: UIViewController {
    @IBOutlet weak var treatmentTableView: UITableView!
    @IBOutlet weak var txtSearch: UISearchBar!
    
    var treatments: [TreatmentModel] = []
    var searchedTreatments:[TreatmentModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTreatmentsData()
    }
    func getTreatmentsData(){
        KVNProgress.show()
        guard let userId = Auth.auth().currentUser?.uid else{return}
        Firestore.firestore().collection("treatment-data").document(userId).collection("category").getDocuments() { (docs, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }else {
                KVNProgress.dismiss()
                print(docs?.documents as Any)
                GlobalData.treatments = []
                for document in docs!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let con = TreatmentModel(dict: document.data())
                    self.treatments.append(con)
                    self.treatmentTableView.reloadData()
                    GlobalData.treatments.append(con);
                }
                self.treatments = self.treatments.sorted(by: {$0.timestamp > $1.timestamp})
                self.searchedTreatments = self.treatments
                self.treatmentTableView.reloadData()
                print(self.searchedTreatments)
            }
        }
    }
    
    @IBAction func OnAddTreatment(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddTreatmentViewController") as! AddTreatmentViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension TreatmentsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedTreatments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TreatmentTableViewCell", for: indexPath) as! TreatmentTableViewCell
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor.white
        
        let treatment = searchedTreatments[indexPath.row]
        cell.lbCategorie.text = treatment.category
        cell.lbDate.text = treatment.inputDate
        cell.lbPractitioner.text = treatment.practitionerName
        cell.lbBudget.text = treatment.cost
        cell.lbEmail.text = treatment.salonEmail
        let url = URL(string: treatment.afterPhoto)
        cell.imgAvata.kf.setImage(with: url, placeholder: UIImage(named: "unselectedSalon"), options: nil)
        cell.delegate = self
        cell.index = indexPath
        
        
        return cell
    }
}
extension TreatmentsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailTreatmentViewController") as! DetailTreatmentViewController
        vc.detailData = treatments[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)

    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        return true
    }
   

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let editBt = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            //self.isEditing = false
            print("edit Button tapped")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditTreatmentViewController") as! EditTreatmentViewController
            vc.editData = self.treatments[indexPath.row]
            vc.documentID = self.treatments[indexPath.row].uuid
            self.navigationController?.pushViewController(vc, animated: true)
        }
        editBt.backgroundColor = UIColor.orange

        let deleteBt = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            //self.isEditing = false
        print("Delete button tapped")
        let alertController = UIAlertController(title: "Alert", message: "Are you sure you want to delete this?", preferredStyle: .alert)
                let showAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    //Delete the cell's images from storage
                    let storage = Storage.storage()
                    let cellBeforePhotoURL = self.treatments[indexPath.row].beforePhoto
                    let celldAfterPhotoURL = self.treatments[indexPath.row].afterPhoto
                    let cellReceiptPhotoURL = self.treatments[indexPath.row].receiptPhoto
                    let cellAdayAfterPhotoURL = self.treatments[indexPath.row].aDayAfterPhoto
                    let cellAweekAfterPhotoURL = self.treatments[indexPath.row].aWeekAfterPhoto
                    let cellAmonthAfterPhotoURL = self.treatments[indexPath.row].aMonthAfterPhoto
                    let childsImageURL = [cellBeforePhotoURL, celldAfterPhotoURL, cellReceiptPhotoURL,cellAdayAfterPhotoURL,cellAweekAfterPhotoURL,cellAmonthAfterPhotoURL]
                    let count = childsImageURL.count
                    KVNProgress.show()
                    for i in 0..<count{
                        if childsImageURL[i] as AnyObject !== "" as AnyObject {
                            let storageRef = storage.reference(forURL: childsImageURL[i])
                            storageRef.delete { error in
                                if let error = error {
                                    KVNProgress.dismiss()
                                    print(error.localizedDescription)
                                } else {
                                    KVNProgress.dismiss()
                                    print("File deleted successfully")
                                }
                            }
                        }
                    }
                    let udid = self.treatments[indexPath.row].uuid
                    let user = Auth.auth().currentUser
                    Firestore.firestore().collection("treatment-data").document((user?.uid)!).collection("category").document(udid).delete { (err) in
                        if let error = err {
                            print(error.localizedDescription)
                        }else {
                            KVNProgress.dismiss()
                            self.searchedTreatments.remove(at: indexPath.row)
                            self.treatmentTableView.reloadData()
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

extension TreatmentsViewController: TreatmentTableViewCellDelegate{
    func didCategoryLabelTap(index: Int) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CategoryDetailViewController") as! CategoryDetailViewController
        vc.category = treatments[index].category
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension TreatmentsViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        txtSearch.endEditing(true)

        if txtSearch.text != "" {
            searchedTreatments = []
            for treat in treatments {

                if treat.category.lowercased().contains(txtSearch.text!.lowercased()) {
                    searchedTreatments.append(treat)
                }
                if treat.salonName.lowercased().contains(txtSearch.text!.lowercased()) {
                    searchedTreatments.append(treat)
                }
            }

            treatmentTableView.reloadData()
        } else {
            searchedTreatments = treatments
            treatmentTableView.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        txtSearch.text = ""
        searchedTreatments = self.treatments
        treatmentTableView.reloadData()
        txtSearch.showsCancelButton = false
        txtSearch.endEditing(true)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        txtSearch.setShowsCancelButton(true, animated: true)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        txtSearch.setShowsCancelButton(false, animated: true)
    }

}
