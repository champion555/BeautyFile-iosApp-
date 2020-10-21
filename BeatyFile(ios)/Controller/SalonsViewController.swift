//
//  SalonsViewController.swift
//  BeatyFile(ios)
//
//  Created by Admin on 4/29/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Firebase
import KVNProgress
class SalonsViewController: UIViewController {
    @IBOutlet weak var txtSearch: UISearchBar!    
    @IBOutlet weak var salonTableView: UITableView!
    
    var salons: [SalonModel] = []
    var searchedSalons:[SalonModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getSalonInfo()
    }
    func getSalonInfo(){
        KVNProgress.show(withStatus: "Loading...", on:view)
        guard let userId = Auth.auth().currentUser?.uid else{return}
        Firestore.firestore().collection("salon-data").document(userId).collection("data").getDocuments() { (docs, err) in
            if let err = err {
                print("Erro getting documents: \(err)")
            }else {
                KVNProgress.dismiss()
                print(docs?.documents as Any)
                GlobalData.salons = []
                for document in docs!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let con = SalonModel(dict: document.data())
                    if self.salons.count > 0{
                        var index = -1
                        for i in 0..<self.salons.count{
                            if self.salons[i].salonName == con.salonName{
                                index = i
                                break
                            }
                        }
                        if index == -1 {
                            self.salons.append(con)
                            self.salonTableView.reloadData()
                            GlobalData.salons.append(con)
                        }
                    }else{
                        self.salons.append(con)
                        self.salonTableView.reloadData()
                        GlobalData.salons.append(con)
                    }
                    
                }
                self.salons = self.salons.sorted(by: {$0.salonName < $1.salonName})
                self.searchedSalons = self.salons
                self.salonTableView.reloadData()
                print(self.searchedSalons)
                
            }
        }
    }

    @IBAction func OnAddSalon(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddSalonViewController") as! AddSalonViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension SalonsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return searchedSalons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SalonTableViewCell", for: indexPath) as! SalonTableViewCell
        let salonInfo = searchedSalons[indexPath.row]
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor.white
        
        cell.lbSalonName.text = salonInfo.salonName
        cell.lbSalonPhonNumber.text = salonInfo.phone
        cell.lbSalonEmail.text = salonInfo.website
        return cell
    }
}
extension SalonsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SalonDetailViewController") as! SalonDetailViewController
        vc.salonName = searchedSalons[indexPath.row].salonName
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
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditSalonViewController") as! EditSalonViewController
            vc.currentData = self.searchedSalons[indexPath.row]
            vc.uuid = self.searchedSalons[indexPath.row].uuid
            self.navigationController?.pushViewController(vc, animated: true)
        }
        editBt.backgroundColor = UIColor.orange

        let deleteBt = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
        print("Delete button tapped")
        let alertController = UIAlertController(title: "Alert", message: "Are you sure you want to delete this?", preferredStyle: .alert)
                let showAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    //Delete the cell's images from firestore
                    let uuid = self.salons[indexPath.row].uuid
                    let user = Auth.auth().currentUser
                    KVNProgress.show()
                    Firestore.firestore().collection("salon-data").document((user?.uid)!).collection("data").document(uuid).delete { (err) in
                        if let error = err {
                            print(error.localizedDescription)
                        }else {
                            KVNProgress.dismiss()
                            self.searchedSalons.remove(at: indexPath.row)
                            self.salonTableView.reloadData()
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
extension SalonsViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        txtSearch.endEditing(true)

        if txtSearch.text != "" {
            searchedSalons = []
            for salon in salons {

                if salon.salonName.lowercased().contains(txtSearch.text!.lowercased()) {
                    searchedSalons.append(salon)
                }
               if salon.phone.lowercased().contains(txtSearch.text!.lowercased()) {
                    searchedSalons.append(salon)
                }

            }

            salonTableView.reloadData()
        } else {
            searchedSalons = salons
            salonTableView.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        txtSearch.text = ""
        searchedSalons = self.salons
        salonTableView.reloadData()
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


