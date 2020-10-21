//
//  HomeViewController.swift
//  BeatyFile(ios)
//
//  Created by Admin on 4/29/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SwiftyStoreKit

class HomeViewController: UIViewController {
    
    @IBOutlet var buttons : [UIButton]!
    
    @IBOutlet weak var imgCategories: UIImageView!
    @IBOutlet weak var imgTreatments: UIImageView!
    @IBOutlet weak var imgSalon: UIImageView!
    @IBOutlet weak var imgBudget: UIImageView!
    @IBOutlet weak var imgAppointments: UIImageView!
    @IBOutlet weak var imgMore: UIImageView!
    
    @IBOutlet weak var lbCategories: UILabel!
    @IBOutlet weak var lbTreatments: UILabel!
    @IBOutlet weak var lbSalons: UILabel!
    @IBOutlet weak var lbBudget: UILabel!
    @IBOutlet weak var lbAppointments: UILabel!
    @IBOutlet weak var lbMore: UILabel!
    
    @IBOutlet weak var viewCategories: UIView!
    @IBOutlet weak var viewTreatment: UIView!
    @IBOutlet weak var viewSalon: UIView!
    @IBOutlet weak var viewBudget: UIView!
    @IBOutlet weak var viewAppoinment: UIView!
    @IBOutlet weak var viewMore: UIView!
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var purchaseView: UIView!
    @IBOutlet weak var btPurchase: UIButton!
    @IBOutlet weak var btRestore: UIButton!
    
    var imgSelects = ["ic_un_categories", "ic_un_treatment", "ic_un_salon","ic_un_budget","ic_un_appointment","ic_un_more"]
    var imgunSelects = ["ic_categories", "ic_treatments", "ic_salon","ic_ budget","ic_appointment","ic_more"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "isPurchased") {
             self.purchaseView.isHidden = true
        } else {
            self.purchaseView.isHidden = false
        }
    }
    
    func configureView(){
        viewCategories.backgroundColor=UIColor(red: 249/255.0, green: 195/255.0, blue: 239/255.0, alpha: 1)
        viewTreatment.backgroundColor=UIColor(red: 249/255.0, green: 195/255.0, blue: 239/255.0, alpha: 1)
        viewSalon.backgroundColor=UIColor(red: 249/255.0, green: 195/255.0, blue: 239/255.0, alpha: 1)
        viewBudget.backgroundColor=UIColor(red: 249/255.0, green: 195/255.0, blue: 239/255.0, alpha: 1)
        viewAppoinment.backgroundColor=UIColor(red: 249/255.0, green: 195/255.0, blue: 239/255.0, alpha: 1)
        viewMore.backgroundColor=UIColor(red: 249/255.0, green: 195/255.0, blue: 239/255.0, alpha: 1)
        
        
        lbCategories.textColor=UIColor(red: 238/255.0, green: 39/255.0, blue: 130/255.0, alpha: 1)
        lbTreatments.textColor=UIColor(red: 238/255.0, green: 39/255.0, blue: 130/255.0, alpha: 1)
        lbSalons.textColor=UIColor(red: 238/255.0, green: 39/255.0, blue: 130/255.0, alpha: 1)
        lbBudget.textColor=UIColor(red: 238/255.0, green: 39/255.0, blue: 130/255.0, alpha: 1)
        lbAppointments.textColor=UIColor(red: 238/255.0, green: 39/255.0, blue: 130/255.0, alpha: 1)
        lbMore.textColor = UIColor(red: 238/255.0, green: 39/255.0, blue: 130/255.0, alpha: 1)
        
        imgCategories.image=UIImage(named: imgunSelects[0])
        imgTreatments.image=UIImage(named: imgunSelects[1])
        imgSalon.image=UIImage(named: imgunSelects[2])
        imgBudget.image=UIImage(named: imgunSelects[3])
        imgAppointments.image=UIImage(named: imgunSelects[4])
        imgMore.image=UIImage(named: imgunSelects[5])
        btPurchase.layer.cornerRadius = 5
        btRestore.layer.cornerRadius = 5
    }
    @IBAction func onPurchase(_ sender: Any) {
        SwiftyStoreKit.purchaseProduct("com.Jenny.MyBeautyRoutine.autopayment", quantity: 1, atomically: true) { result in
               switch result {
               case .success(let purchase):
                    print("Purchase Success: \(purchase.productId)")
                    UserDefaults.standard.set(true, forKey: "isPurchased")
                    self.purchaseView.isHidden = true
///
               case .error(let error):
                   switch error.code {
                   case .unknown: print("Unknown error. Please contact support")
                   case .clientInvalid: print("Not allowed to make the payment")
                   case .paymentCancelled: break
                   case .paymentInvalid: print("The purchase identifier was invalid")
                   case .paymentNotAllowed: print("The device is not allowed to make the payment")
                   case .storeProductNotAvailable: print("The product is not available in the current storefront")
                   case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                   case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                   case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                   default: print((error as NSError).localizedDescription)
                   }
               }
           }
    }
    
    @IBAction func onRestore(_ sender: Any) {
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
               if results.restoreFailedPurchases.count > 0 {
                   print("Restore Failed: \(results.restoreFailedPurchases)")
               }
               else if results.restoredPurchases.count > 0 {
                    print("Restore Success: \(results.restoredPurchases)")
                    UserDefaults.standard.set(true, forKey: "isPurchased")
                    self.purchaseView.isHidden = true
               }
               else {
                   print("Nothing to Restore")
               }
           }
    }
    @IBAction func didPreeTab(_ sender: UIButton){
        
        switch sender.tag{
            case 1:
                configureView()
                imgTreatments.image=UIImage(named: imgSelects[1])
                viewTreatment.backgroundColor=UIColor(red: 249/255.0, green: 195/255.0, blue: 239/255.0, alpha: 1)
                lbTreatments.textColor=UIColor.white
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "nav_Treatments") as! UINavigationController
                    //Add View Controller as Child View Controller
                self.add(vc : vc, nextview : 1)
            break
            case 2:
                
                configureView()
                imgCategories.image=UIImage(named: imgSelects[0])
                viewCategories.backgroundColor=UIColor(red: 249/255.0, green: 195/255.0, blue: 239/255.0, alpha: 1)
                lbCategories.textColor=UIColor.white
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "nav_Categories") as! UINavigationController
                    //Add View Controller as Child View Controller
                self.add(vc : vc, nextview : 2)
            break
            case 3:
                configureView()
                imgSalon.image=UIImage(named: imgSelects[2])
                viewSalon.backgroundColor=UIColor(red: 249/255.0, green: 195/255.0, blue: 239/255.0, alpha: 1)
                lbSalons.textColor=UIColor.white
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "nav_Salon") as! UINavigationController
                    //Add View Controller as Child View Controller
                self.add(vc : vc, nextview : 3)
            break
            case 4:
                configureView()
                imgBudget.image=UIImage(named: imgSelects[3])
                viewBudget.backgroundColor=UIColor(red: 249/255.0, green: 195/255.0, blue: 239/255.0, alpha: 1)
                lbBudget.textColor=UIColor.white
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "nav_Budget") as! UINavigationController
                    //Add View Controller as Child View Controller
                self.add(vc : vc, nextview : 4)
            break
            case 5:
                configureView()
                imgAppointments.image=UIImage(named: imgSelects[4])
                viewAppoinment.backgroundColor=UIColor(red: 249/255.0, green: 195/255.0, blue: 239/255.0, alpha: 1)
                lbAppointments.textColor=UIColor.white
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "nav_Appointments") as! UINavigationController
                    //Add View Controller as Child View Controller
                self.add(vc : vc, nextview : 5)
            break
            case 6:
                configureView()
                imgMore.image=UIImage(named: imgSelects[5])
                viewMore.backgroundColor=UIColor(red: 249/255.0, green: 195/255.0, blue: 239/255.0, alpha: 1)
                lbMore.textColor=UIColor.white
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "nav_More") as! UINavigationController
                    //Add View Controller as Child View Controller
                self.add(vc : vc, nextview : 6)
            break
            
        default:
            break
        }
    }
    func add(vc : UIViewController , nextview : Int) {
       //Add Child View Controller
       addChild(vc)
       //Add Child View as Subview
       view.addSubview(vc.view)
       //Configure Child View
       vc.view.frame = viewContainer.bounds
       vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       //Notify Child View Controller
       vc.didMove(toParent: self)
        viewContainer.addSubview(vc.view)
        
    }
}
