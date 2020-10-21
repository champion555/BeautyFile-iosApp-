//
//  CategoryDetailViewController.swift
//  BeatyFile(ios)
//
//  Created by Admin on 6/3/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import KVNProgress
import Firebase
import Kingfisher

class CategoryDetailViewController: UIViewController {
    @IBOutlet weak var tableCategoryDetail: UITableView!
    @IBOutlet weak var txtSearch: UISearchBar!
    @IBOutlet weak var lbTitle: UILabel!
    var category = ""
    var treatments: [TreatmentModel] = []
    var searchedTreatments:[TreatmentModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbTitle.text = category
        getData()

    }
    func getData(){
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
                        if self.category == con.category{
                            self.treatments.append(con)
                            self.tableCategoryDetail.reloadData()
                             GlobalData.treatments.append(con);
                        }
                    }
                    self.searchedTreatments = self.treatments
                    self.tableCategoryDetail.reloadData()
                    print(self.searchedTreatments)
                }
        }
    }
    
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension CategoryDetailViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryDetailTableViewCell", for: indexPath) as! CategoryDetailTableViewCell
        
        let treatment = searchedTreatments[indexPath.row]
        
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor.white
        
        cell.lbDate.text = treatment.inputDate
        cell.lbEmail.text = treatment.salonEmail
        cell.lbSalon.text = treatment.salonName
        cell.lbPhone.text = treatment.salonPhoneNum
        cell.lbPractitioner.text = treatment.practitionerName
        cell.lbCost.text = treatment.cost
        let url = URL(string: treatment.afterPhoto)
        cell.imgView.kf.setImage(with: url, placeholder: UIImage(named: "ic_treatments"), options: nil)
         return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    

        return searchedTreatments.count
    }
}
extension CategoryDetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
extension CategoryDetailViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        txtSearch.endEditing(true)

        if txtSearch.text != "" {
            searchedTreatments = []
            for treat in treatments {

                if treat.salonPhoneNum.lowercased().contains(txtSearch.text!.lowercased()) {
                    searchedTreatments.append(treat)
                }
                if treat.salonName.lowercased().contains(txtSearch.text!.lowercased()) {
                    searchedTreatments.append(treat)
                }
                if treat.salonEmail.lowercased().contains(txtSearch.text!.lowercased()) {
                    searchedTreatments.append(treat)
                }

            }

            tableCategoryDetail.reloadData()
        } else {
            searchedTreatments = treatments
            tableCategoryDetail.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        txtSearch.text = ""
        searchedTreatments = self.treatments
        tableCategoryDetail.reloadData()
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
