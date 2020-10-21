//
//  AppointModel.swift
//  BeatyFile(ios)
//
//  Created by Admin on 5/19/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class AppointmentsModel: NSObject {
    
    var appoinmentDate = ""
    var salonName = ""
    var treatment = ""
    var website = ""
    var phone = ""
    
    override init() {
        super.init()
    }
    
    init(dict: [String: Any]) {
        if let val = dict["appoinmentDate"] as? String          { appoinmentDate = val }
        if let val = dict["salonName"] as? String               { salonName = val }
        if let val = dict["treatment"] as? String               { treatment = val }
        if let val = dict["website"] as? String                 { website = val }
        if let val = dict["phone"] as? String                   { phone = val }
    }
}
//let body = [
//    "appoinmentDate": appointmentDate,
//    "salonName": salonName,
//    "treatment": treatment
//]
