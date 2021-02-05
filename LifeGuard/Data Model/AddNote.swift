//
//  AddNote.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-01-29.
//

import Foundation
import RealmSwift


class AddNote: Object {
    @objc dynamic var title: String = "Add Note"
    @objc dynamic var date = Date()
    
    var parentCategory = LinkingObjects(fromType: CategoryLogbook.self, property: "notes")
    
}
