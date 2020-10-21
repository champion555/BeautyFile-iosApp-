//
//  CategoriesViewController.swift
//  BeatyFile(ios)
//
//  Created by Admin on 4/29/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Firebase
import KVNProgress

class CategoriesViewController: UIViewController {
    @IBOutlet weak var categoryTableView: UITableView!
    var categories: [CategoryModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTableView.estimatedRowHeight = 100
        getCategory()
    }
    func getCategory(){
        categories = []
        KVNProgress.show(withStatus: "Loading...", on:view)
        guard let userId = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("treatment-data").document(userId).collection("category").getDocuments() { (docs, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }else {
                KVNProgress.dismiss()
                for document in docs!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let con = TreatmentModel(dict: document.data())
                    
                    if self.categories.count > 0 {
                        var index = -1
                        for i in 0..<self.categories.count {
                            if self.categories[i].name == con.category {
                                index = i
                                break
                            }
                        }
                        if index == -1 {
                            let cat = CategoryModel()
                            cat.name = con.category
                            cat.dateAry.append(con.inputDate + " - " + con.salonName)
                            self.categories.append(cat)
                        } else {
                            self.categories[index].dateAry.append(con.inputDate + " - " + con.salonName)
                        }
                    } else {
                        let cat = CategoryModel()
                        cat.name = con.category
                        cat.dateAry.append(con.inputDate + " - " + con.salonName)
                        self.categories.append(cat)
                    }
    
                }
                self.categories = self.categories.sorted(by: {$0.name < $1.name})
                self.categoryTableView.reloadData()
            }

        }
        
    }
}

extension CategoriesViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor.white
        let category = categories[indexPath.row]
        var content = ""        
        for i in 0..<category.dateAry.count {
            if i != category.dateAry.count - 1 {
                content += category.dateAry[i] + "\n"
            } else {
                content += category.dateAry[i]
            }
        }
        
        cell.lbCategory.text = "\(category.name)"
        cell.lbCategoryArr.text = content
        return cell
    }
}
extension CategoriesViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CategoryDetailViewController") as! CategoryDetailViewController
        vc.category = categories[indexPath.row].name
        self.navigationController?.pushViewController(vc, animated: true)

    }
}
