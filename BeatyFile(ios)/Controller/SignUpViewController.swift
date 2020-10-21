//
//  SignUpViewController.swift
//  BeatyFile(ios)
//
//  Created by Admin on 4/29/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import KVNProgress
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {
    @IBOutlet var uiViews: [UIView]!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btCreateAccount: UIButton!
    @IBOutlet weak var btBackLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()

    }
    func configureView(){
        btBackLogin.layer.cornerRadius=5
        btCreateAccount.layer.cornerRadius=5
        for viewItem in uiViews{
            viewItem.layer.borderWidth = 1
            viewItem.layer.cornerRadius=5
            viewItem.layer.borderColor = UIColor.white.cgColor
        }
        txtPassword.isSecureTextEntry = true
        txtConfirmPassword.isSecureTextEntry = true
    }

    @IBAction func OnCreateAccount(_ sender: Any) {
        let email = txtEmail.text!
        let password = txtPassword.text!
        let conPassword = txtConfirmPassword.text!
        if email.count == 0 {
            CommonManager.shared.showAlert(viewCtrl: self, title: "Warning", msg: "Please enter email")
            return
        } else if !CommonManager.shared.isValidEmail(testStr: email) {
            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Invalid Email")
            return
        }
        if password.count == 0 {
            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Please enter password")
            return
        } else if password.count < 6 {
            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Password should be minimum 6 characters")
            return
        }
        if conPassword.count == 0 {
            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Please enter Confirm password")
            return
        }else if conPassword.count < 6 {
            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Password should be minimum 6 characters")
            return
        }
        if password == conPassword {
            KVNProgress.show(withStatus: "Saving...", on: view)
            Auth.auth().createUser(withEmail: email, password: password, completion: {
            user, error in
                  if error != nil || user == nil {
                      KVNProgress.showError(withStatus: error?.localizedDescription, on: self.view)
                  }else{
                    KVNProgress.dismiss()
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            })
            
        }else{
            CommonManager.shared.showAlert(viewCtrl: self, title: "Warning", msg: "Error, password should be equal confirmpassword")
            return
        }
        
    }
    @IBAction func OnBackLogin(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

