//
//  PrivacyPolicyViewController.swift
//  BeatyFile(ios)
//
//  Created by Admin on 6/3/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {
    @IBOutlet var lbBoldTitles : [ UILabel]!
    @IBOutlet weak var lbTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    func configureView(){
        lbTitle.font = UIFont.boldSystemFont(ofSize: 22)
        for lbItem in lbBoldTitles {
            lbItem.font = UIFont.boldSystemFont(ofSize: 18)
        }
    }
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

}
