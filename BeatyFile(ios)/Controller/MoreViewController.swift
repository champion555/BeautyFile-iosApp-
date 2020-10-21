//
//  MoreViewController.swift
//  BeatyFile(ios)
//
//  Created by Admin on 6/2/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    @IBOutlet var uiLabel : [UILabel]!
    @IBOutlet weak var lbTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    func configureView(){
        
        
    }
    
    @IBAction func onNext(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InstructionsViewController") as! InstructionsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
