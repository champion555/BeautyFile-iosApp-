//
//  BudgetViewController.swift
//  BeatyFile(ios)
//
//  Created by Admin on 4/29/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Firebase
import KVNProgress
class BudgetViewController: UIViewController {
    
    @IBOutlet weak var budgetTableView: UITableView!
    var budgets: [BudgetModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        budgetTableView.estimatedRowHeight = 100
        getBudgetData()
    }
    func getBudgetData(){
        budgets = []
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
                    let date = con.inputDate.split(separator: " ")[1]
                    if self.budgets.count > 0 {
                        var index = -1
                        for i in 0..<self.budgets.count{
                            if self.budgets[i].month == date{
                                index = i
                                break
                            }
                        }
                        if index == -1{
                            let bud = BudgetModel()
                            bud.month = String(date)
                            bud.categoryArr.append(con.category)
                            bud.budgetArr.append(con.cost)
                            self.budgets.append(bud)
                        }else{
                            self.budgets[index].budgetArr.append(con.cost)
                            self.budgets[index].categoryArr.append(con.category)
                        }
                    }else {
                        let bud = BudgetModel()
                        bud.month = String(date)
                        bud.categoryArr.append(con.category)
                        bud.budgetArr.append(con.cost)
                        self.budgets.append(bud)
                    }                    
                }
                self.budgetTableView.reloadData()
            }
        }
    }

}
extension BudgetViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return budgets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BudgetTableViewCell", for: indexPath) as! BudgetTableViewCell
        let budget = budgets[indexPath.row]
        var contentbud = ""
        var contentcat = ""
        var totalBudget: Int = 0
        for i in 0..<budget.budgetArr.count{
            if i != budget.budgetArr.count - 1 {
                contentbud += "$\(budget.budgetArr[i])" + "\n"
                totalBudget += (Int(budget.budgetArr[i]))!
            }else{
                contentbud += "$\(budget.budgetArr[i])"
                totalBudget += (Int(budget.budgetArr[i]))!
            }
        }
        for j in 0..<budget.categoryArr.count{
            if j != budget.categoryArr.count - 1 {
                contentcat += budget.categoryArr[j] + "\n"
            }else{
                contentcat += budget.categoryArr[j]
            }
        }
        let Tbudget = String(totalBudget)
        
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor.white
        
        cell.lbMonth.text = budget.month
        cell.lbCategory.text = contentcat
        cell.lbBudget.text = contentbud
         cell.lbTotalBudget.text = "$\(Tbudget)"
        return cell
    }
}
extension BudgetViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = UIColor.white
    }
}
