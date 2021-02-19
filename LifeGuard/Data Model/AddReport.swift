//
//  AddReport.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-02-19.
//

import Foundation
import RealmSwift

class AddReport: Object {
 
    @objc dynamic var date = Date()
    @objc dynamic var reportDate = ""
    @objc dynamic var lifeGuardName: String = ""
    @objc dynamic var lifeStation = ""
    @objc dynamic var place = ""
    @objc dynamic var alarmed = ""
    @objc dynamic var lifeEquipment = ""
    @objc dynamic var extraHelp = ""
    @objc dynamic  var lifeNote = ""
    
    @objc dynamic var rescuedName = ""
    @objc dynamic var ageGender = ""
    @objc dynamic var sign = ""
    @objc dynamic var found = ""
    @objc dynamic var swim = ""
    @objc dynamic var unconscious = ""
    @objc dynamic var rescuedNote = ""
    
    @objc dynamic var disease = ""
    @objc dynamic var procedure = ""
    @objc dynamic var caseDescribe = ""
    
    @objc dynamic var improvement = ""
    
    
}
