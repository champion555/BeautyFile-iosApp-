//
//  InstructionsViewController.swift
//  BeatyFile(ios)
//
//  Created by Admin on 6/3/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController {
    @IBOutlet var lbBoldTitles : [UILabel]!
    @IBOutlet weak var lbTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    func configureView(){
        lbTitle.font = UIFont.boldSystemFont(ofSize: 22)
        for labelItem in lbBoldTitles{
            labelItem.font = UIFont.boldSystemFont(ofSize: 18)
        }
    }
   
    @IBAction func onNext(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
