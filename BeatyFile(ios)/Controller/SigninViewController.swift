//
//  LoginViewController.swift
//  BeatyFile(ios)
//
//  Created by Admin on 4/29/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Firebase
import KVNProgress

class SigninViewController: UIViewController {
    @IBOutlet var uiViews: [UIView]!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btLogin: UIButton!
    @IBOutlet weak var btCreateAccount: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.bool(forKey: "isloggedin") == true{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        configureView()
        
    }
    func configureView(){
        btLogin.layer.cornerRadius = 5
        for itemView in uiViews{
            itemView.layer.borderWidth = 1
            itemView.layer.borderColor = UIColor.white.cgColor
            itemView.layer.cornerRadius = 5
        }
        txtPassword.isSecureTextEntry = true
    }

    @IBAction func OnLogin(_ sender: Any) {
        let email = txtEmail.text!
        let password = txtPassword.text!
        if email.count == 0 {
            CommonManager.shared.showAlert(viewCtrl: self, title: "Reminder", msg: "Please enter email")
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
        KVNProgress.show(withStatus: "Loading...", on: view)
        Auth.auth().signIn(withEmail: email, password: password, completion: {
            user, error in
            
            if error != nil {
                KVNProgress.showError(withStatus: error!.localizedDescription, on: self.view)
            } else {
                if user == nil {
                    CommonManager.shared.showAlert(viewCtrl: self, title: "connecting erro", msg: "Please check your network status again.")
                    
                } else {
                        KVNProgress.dismiss()
                        UserDefaults.standard.set(true, forKey: "isloggedin")
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
            }
        })
    }
    
    @IBAction func OnCreateAccount(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: true) 
    }
    
    @IBAction func onForgotPassword(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

