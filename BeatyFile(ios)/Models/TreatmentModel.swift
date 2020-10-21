//
//  TreatmentModel.swift
//  BeatyFile(ios)
//
//  Created by Admin on 4/30/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
class TreatmentModel: NSObject {
    var timestamp = 0
    var uuid = ""
    var uid = ""
    var inputDate = ""
    var category = ""
    var practitionerName = ""
    var salonName = ""
    var salonPhoneNum = ""
    var salonEmail = ""
    var treatmentDescription = ""
    var cost = ""
    var comment = ""
    var beforePhoto = ""
    var afterPhoto = ""
    var receiptPhoto = ""
    var aDayAfterPhoto = ""
    var aWeekAfterPhoto = ""
    var aMonthAfterPhoto = ""

    override init() {
        super.init()
    }

    init(dict: [String: Any]) {
        if let val = dict["timestamp"] as? Int                      { timestamp = val}
        if let val = dict["uuid"] as? String                        { uuid = val}
        if let val = dict["uid"] as? String                         { uid = val }
        if let val = dict["inputDate"] as? String                   { inputDate = val }
        if let val = dict["category"] as? String                    { category = val }
        if let val = dict["practitionerName"] as? String            { practitionerName = val }
        if let val = dict["salonName"] as? String                   { salonName = val }
        if let val = dict["salonPhoneNum"] as? String               { salonPhoneNum = val }
        if let val = dict["salonEmail"] as? String                  { salonEmail = val }
        if let val = dict["treatmentDescription"] as? String        { treatmentDescription = val }
        if let val = dict["cost"] as? String                        { cost = val }
        if let val = dict["comment"] as? String                     { comment = val }
        if let val = dict["beforePhoto"] as? String                 { beforePhoto = val }
        if let val = dict["afterPhoto"] as? String                  { afterPhoto = val }
        if let val = dict["receiptPhoto"] as? String                { receiptPhoto = val }
        if let val = dict["aDayAfterPhoto"] as? String              { aDayAfterPhoto = val }
        if let val = dict["aWeekAfterPhoto"] as? String             { aWeekAfterPhoto = val }
        if let val = dict["aMonthAfterPhoto"] as? String            { aMonthAfterPhoto = val }
        
    }
}
