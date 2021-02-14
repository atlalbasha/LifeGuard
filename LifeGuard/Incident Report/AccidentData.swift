//
//  AccidentData.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-02-04.
//

import Foundation

import Foundation

import ObjectForm
import UIKit

class AccidentData: NSObject, FormDataSource {
 

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

    var bindModel: Accident

    init(_ accident: Accident) {
        self.bindModel = accident
        
        
       

        
        basicRows.append(SelectRow(title: "Type of Disease, Accident",
                                   icon: "",
                                   kvcKey: "type",
                                   value: accident.type,
                                   
                                   listOfValues: ["Heart Attack", "Neck-Back Injury", "Heat Stroke","Wounds","Worm Body Part","Snake,Insect Animal Bite","Cramp ","Drowning","Jellyfish", "Fire","Shock", "Head Injury","Burns","External Bleeding","Lose a Tooth", "Asthma","Missing Person","Threat, Violence","Fainting","Circulatory Failure", "Cooling","Fractures, Sprain", "Nosebleeds",  "Allergic Reaction",  "Diabetes","Kris, Chock,",    "Posoning, Burns", " Prevention","-"]))
        
        basicRows.append(StringRow(title: "Other Accident:",
                                   icon: "",
                                   kvcKey: "accident",
                                   value: accident.accident ?? "",
                                   placeholder: "not found in list."))

        
        
      
    

        basicRows.append(SelectRow(title: "Procedure",
                                   icon: "",
                                   kvcKey: "procedure",
                                   value: accident.procedure,
                                   
                                   listOfValues: ["Rescue Below The Surface","Rescue at The Surface","Towing","Transport to Ambulance","Trasport to Hospital","Breath i Water","Breath on Beach","Fire Extinguisher","Stable Side Position","Blanket, Nursing","Defibrillation","Cooling","Alarmed SOS", "HLR", "Skull Passage Chain","Manual Fixation","High Mode","Plan Mode", "Trasport Taxi","-"]))
        
        basicRows.append(StringRow(title: "Other Procedure:",
                                   icon: "",
                                   kvcKey: "yourProc",
                                   value: accident.yourProc ?? "",
                                   placeholder: "not found in list."))
        
   
        
        basicRows.append(TextViewRow(title: "Descibe the Case:",
                                     kvcKey: "note",
                                     value: accident.note ?? "-"))

//        basicRows.append(ButtonRow(title: "Delete",
//                                   image: UIImage(systemName: "trash")!,
//                                   tintColor: .systemRed,
//                                   actionTag: "deleteTag"))
//
    
    }

    override init() { fatalError("not implemented") }
}
