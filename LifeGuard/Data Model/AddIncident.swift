//
//  AddIncident.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-01-31.
//

import Foundation
import RealmSwift

class AddIncident: Object {
    @objc dynamic var date = Date()
    @objc dynamic var name: String = "Lifeguard Name"
    @objc dynamic var person: String = "Person"
    @objc dynamic var place: String = "Place"
    @objc dynamic var accident: String = "Accident"
    @objc dynamic var procedure: String = "Procedure"
    
    
}
