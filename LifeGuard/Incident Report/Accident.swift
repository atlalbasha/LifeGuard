//
//  Accident.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-02-04.
//

import Foundation




@objc class Accident: NSObject {
    @objc dynamic var accident: String?
    @objc dynamic var type: String?
    @objc dynamic var procedure: String?
    @objc dynamic var yourProc: String?
    @objc dynamic var note: String?
    @objc dynamic var improvement: String?
    

    convenience init(accident: String? ,type: String?, yourProc: String? ,procedure: String? , improvement: String?) {
        self.init()
        self.accident = accident
        self.type = type
        self.yourProc = yourProc
        self.procedure = procedure
        self.note = note
        self.improvement = improvement
    }
}
