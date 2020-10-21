//
//  SalonDetailViewController.swift
//  BeatyFile(ios)
//
//  Created by Admin on 6/3/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import KVNProgress
import Firebase
import Kingfisher

class SalonDetailViewController: UIViewController {
    @IBOutlet weak var tableSalonDetail: UITableView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var txtSearch: UISearchBar!
    var salonName = ""
    var treatments: [TreatmentModel] = []
    var searchedTreatments:[TreatmentModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        lbTitle.text = salonName
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
                        if self.salonName == con.salonName{
                            self.treatments.append(con)
                            self.tableSalonDetail.reloadData()
                             GlobalData.treatments.append(con);
                        }
                    }
                    self.searchedTreatments = self.treatments
                    self.tableSalonDetail.reloadData()
                    print(self.searchedTreatments)
                }
        }
        
    }
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
extension SalonDetailViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "SalonDetailTableViewCell", for: indexPath) as! SalonDetailTableViewCell
        
        let treatment = searchedTreatments[indexPath.row]
        
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor.white
        
        cell.lbDate.text = treatment.inputDate
        cell.lbCost.text = treatment.cost
        cell.lbCategory.text = treatment.category
        cell.lbPractitioner.text = treatment.practitionerName
        cell.lbSalon.text = treatment.salonName
        cell.lbWebsite.text = treatment.salonEmail
        let url = URL(string: treatment.afterPhoto)
        cell.imgView.kf.setImage(with: url, placeholder: UIImage(named: "ic_treatments"), options: nil)
         return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    

        return searchedTreatments.count
    }
}
extension SalonDetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
extension SalonDetailViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        txtSearch.endEditing(true)

        if txtSearch.text != "" {
            searchedTreatments = []
            for treat in treatments {

                if treat.category.lowercased().contains(txtSearch.text!.lowercased()) {
                    searchedTreatments.append(treat)
                }
                if treat.practitionerName.lowercased().contains(txtSearch.text!.lowercased()) {
                    searchedTreatments.append(treat)
                }
            }

            tableSalonDetail.reloadData()
        } else {
            searchedTreatments = treatments
            tableSalonDetail.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        txtSearch.text = ""
        searchedTreatments = self.treatments
        tableSalonDetail.reloadData()
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
