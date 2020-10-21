//
//  wwwViewController.swift
//  BeatyFile(ios)
//
//  Created by Admin on 6/4/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class wwwViewController: UIViewController {
    @IBOutlet weak var tableWWW: UITableView!
    var data = ["adaf","adfas","adfas","adfasd","dafds"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

}
extension wwwViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "wwwTableViewCell", for: indexPath) as! wwwTableViewCell
        
        cell.lbtitle.text = data[indexPath.row]
        
         return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    

        return data.count
    }
}
extension wwwViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if (editingStyle == UITableViewCell.EditingStyle.delete) {
//            // delete data and row
//            data.remove(at: indexPath.row)
//            tableWWW.deleteRows(at: [indexPath], with: .fade)
//        }
//
//    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let more = UITableViewRowAction(style: .normal, title: "More") { action, index in
            //self.isEditing = false
            print("more button tapped")
        }
        more.backgroundColor = UIColor.lightGray

        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { action, index in
            //self.isEditing = false
            print("favorite button tapped")
        }
        favorite.backgroundColor = UIColor.orange

        let share = UITableViewRowAction(style: .normal, title: "Share") { action, index in
            //self.isEditing = false
            print("share button tapped")
        }
        share.backgroundColor = UIColor.blue

        return [share, favorite, more]
    }
    
}
