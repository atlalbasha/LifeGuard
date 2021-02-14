//
//  AccountForm+UITableVIew.swift
//  Mocha
//
//  Created by Jake on 6/16/19.
//  Copyright © 2019 Mocha. All rights reserved.
//

import ObjectForm
import UIKit

class LifeGuardData: NSObject, FormDataSource {
    typealias BindModel = LifeGuard

    var basicRows: [BaseRow] = []

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(at section: Int) -> Int {
        switch section {
        case 0: return basicRows.count
        default: fatalError()
        }
    }

    func row(at indexPath: IndexPath) -> BaseRow {
        switch indexPath.section {
        case 0: return basicRows[indexPath.row]
        default: fatalError()
        }
    }

    var bindModel: LifeGuard

    init(_ lifeguard: LifeGuard) {
        self.bindModel = lifeguard

        basicRows.append(StringRow(title: "LifeGuard Name:",
                                   icon: "",
                                   kvcKey: "name",
                                   value: lifeguard.name ?? "",
                                   placeholder: "Type Your Name...",
                                   validator: {
                                    return !(lifeguard.name?.isEmpty ?? true)

        }))

        basicRows.append(StringRow(title: "LifeSaving Station:",
                                   icon: "",
                                   kvcKey: "station",
                                   value: lifeguard.station,
                                   placeholder: "Ex. Askim Strand.."))
        
    

     

//        basicRows.append(DateRow(title: "Purchase Date",
//                                 icon: "",
//                                 kvcKey: "date",
//                                 value: fruit.date ?? Date(),
//                                 placeholder: ""))
        
    
        
        
        
      

        basicRows.append(SelectRow(title: "Place of the Instance:",
                                   icon: "",
                                   kvcKey: "place",
                                   value: lifeguard.place,
                                   
                                   listOfValues: ["Water", "Beach" ,"Less Than 50 meter of Beach","50-100 meter of Beach", "100-200 meter of Beach", "More Than 200 meter of Beach","-"]))
        
        basicRows.append(SelectRow(title: "Who Alarmed:",
                                   icon: "",
                                   kvcKey: "alarmed",
                                   value: lifeguard.alarmed,
                                   listOfValues: ["Public", "LifeGuard", "Other","-"]))
        
        basicRows.append(SelectRow(title: "Lifesaving Equipment:",
                                   icon: "",
                                   kvcKey: "equipment",
                                   value: lifeguard.equipment,
                                   listOfValues: ["Nothing","Livboj","Torpedo","Rescue Board","Drones", "Boat", "Jet Ski","-"]))
        
        
  
        
        basicRows.append(SelectRow(title: "External Help",
                                   icon: "",
                                   kvcKey: "extaHelp",
                                   value: lifeguard.extaHelp,
                                   listOfValues: ["Abmbulance","Rescue Service","Sea Rescue","The Coast Guard","Helicopter", "Polis", "Public","-"]))
        
        
        basicRows.append(TextViewRow(title: "Note",
                                     kvcKey: "note",
                                     value: lifeguard.note ?? "-"))

//        basicRows.append(ButtonRow(title: "Delete",
//                                   image: UIImage(systemName: "trash")!,
//                                   tintColor: .systemRed,
//                                   actionTag: "deleteTag"))
//        
    
    }

    override init() { fatalError("not implemented") }
}
