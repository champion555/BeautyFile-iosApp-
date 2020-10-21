//
//  SalonModel.swift
//  BeatyFile(ios)
//
//  Created by Admin on 6/9/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class SalonModel: NSObject {
    var uuid = ""
    var salonName = ""
    var website = ""
    var phone = ""
    
    override init() {
        super.init()
    }
    
    init(dict: [String: Any]) {
        if let val = dict["uuid"] as? String                    { uuid = val }
        if let val = dict["salonName"] as? String               { salonName = val }
        if let val = dict["website"] as? String                 { website = val }
        if let val = dict["phone"] as? String                   { phone = val }
    }
}
