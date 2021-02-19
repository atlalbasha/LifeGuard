//
//  Fruit.swift
//  ObjectFormExample
//
//  Created by Jake on 2/29/20.
//  Copyright © 2020 Jake. All rights reserved.
//

import Foundation

@objc class LifeGuard: NSObject {
    @objc dynamic var name: String?
    @objc dynamic var station: String?
    @objc dynamic var place: String?
    @objc dynamic var alarmed: String?
    @objc dynamic var equipment: String?
    @objc dynamic var extraHelp: String?
    @objc dynamic var note: String?
    

    convenience init(name: String?, station: String?, place: String?, alarmed: String?, equipment: String?, extraHelp: String?, date: Date? = Date()) {
        self.init()
        self.name = name
        self.station = station
        self.place = place
        self.alarmed = alarmed
        self.equipment = equipment
        self.extraHelp = extraHelp
        self.note = note
    }
}
