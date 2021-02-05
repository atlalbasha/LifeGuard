//
//  ItemLogbook.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-01-22.
//

import Foundation
import RealmSwift


class ItemLogbook: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var date: Date?
    
    @objc dynamic var air_temp: String = ""
    @objc dynamic var water_temp: String = ""
    
    @objc dynamic var wind_speed: String = ""
    @objc dynamic var wind_direction: String = ""
    
    @objc dynamic var people_in_water: String = ""
    @objc dynamic var people_on_beach: String = ""
    
    @objc dynamic var flag: String = ""
    @objc dynamic var streams: String = ""
    
    @objc dynamic var note: String = ""
//    
    var parentCategory = LinkingObjects(fromType: CategoryLogbook.self, property: "items")
}
