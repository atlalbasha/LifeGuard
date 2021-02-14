//
//  Rescued.swift
//  TestForm
//
//  Created by Atlal Basha on 2021-02-09.
//

import Foundation



@objc class Rescued: NSObject {
    @objc dynamic var name: String?
    @objc dynamic var age: String?
    @objc dynamic var signe: String?
    @objc dynamic var found: String?
    @objc dynamic var swim: String?
    @objc dynamic var unconscious: String?
    @objc dynamic var note: String?
    

    convenience init(name: String?, age: String?, signe: String?, found: String?, swim: String?, unconscious: String?) {
        self.init()
        self.name = name
        self.age = age
        self.signe = signe
        self.found = found
        self.swim = swim
        self.unconscious = unconscious
        self.note = note
    }
}
