//
//  ForgotPasswordViewController.swift
//  BeatyFile(ios)
//
//  Created by Admin on 6/23/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import KVNProgress
import Firebase

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var uiview: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    func configureView(){
        uiview.layer.cornerRadius = 5
        btnSend.layer.cornerRadius = 5
    }
    
    @IBAction func onSendEmail(_ sender: Any) {
        let email = txtEmail.text!
            if email.count == 0 {
                CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Please enter your email.")
                return
            } else if !CommonManager.shared.isValidEmail(testStr: email) {
                CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Invalid Email.")
                return
            }
            KVNProgress.show(withStatus: "", on: view)
            
            Auth.auth().sendPasswordReset(withEmail: email, completion: {
                error in

                if error != nil {
                    KVNProgress.showError(withStatus: error!.localizedDescription, on: self.view)
                }
                else {
                    print(email)
                    KVNProgress.dismiss()
                }
        
            })
        
    }
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
}
