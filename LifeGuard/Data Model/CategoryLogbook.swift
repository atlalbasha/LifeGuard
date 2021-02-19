//
//  CategoryLogbook.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-01-22.
//

import Foundation
import RealmSwift

//let date = Date()
//let formatter = DateFormatter()



class CategoryLogbook: Object {
    
    @objc dynamic var title: String = "Logbook"
    @objc dynamic var date: Date? // =  getCurrentDate() 
    
    let items = List<ItemLogbook>()
 
    
    
}

//func getCurrentDate() -> String {
//
//    formatter.dateFormat = "E, d MMM yyyy"
//    let result = formatter.string(from: date)
//    return result
//}

// date with current timezone

//func getCurrentDate() -> String {
//    formatter.timeZone = .current
//    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//    let result = formatter.string(from: dateCreated)
//    return result
//}







