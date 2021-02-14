//
//  RescuedData.swift
//  TestForm
//
//  Created by Atlal Basha on 2021-02-09.
//

import Foundation

import ObjectForm
import UIKit

class RescuedData: NSObject, FormDataSource {
 

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

    var bindModel: Rescued

    init(_ rescued: Rescued) {
        self.bindModel = rescued

        basicRows.append(StringRow(title: "Rescued Name:",
                                   icon: "",
                                   kvcKey: "name",
                                   value: rescued.name ?? "",
                                   placeholder: "Type Name...",
                                   validator: {
                                    return !(rescued.name?.isEmpty ?? true)

        }))
        
       
     
       

        basicRows.append(StringRow(title: "Age, Gender:",
                                   icon: "",
                                   kvcKey: "age",
                                   value: rescued.age,
                                   placeholder: "Ex. 23y, Man"))
        
    

        basicRows.append(SelectRow(title: "Emergency Signs, Shouts:",
                                   icon: "",
                                   kvcKey: "signe",
                                   value: rescued.signe,
                                   
                                   listOfValues: ["Yes", "No", "Maybe" ,"-"]))
        
        basicRows.append(SelectRow(title: "Found Below The Surface:",
                                   icon: "",
                                   kvcKey: "found",
                                   value: rescued.found,
                                   listOfValues: ["Yes", "Now", "Other","-"]))
        
        basicRows.append(SelectRow(title: "Can Swim:",
                                   icon: "",
                                   kvcKey: "swim",
                                   value: rescued.swim,
                                   listOfValues: ["Yes","No", "Bad Swim","-"]))
        
        
  
        
        basicRows.append(SelectRow(title: "Unconscious:",
                                   icon: "",
                                   kvcKey: "unconscious",
                                   value: rescued.unconscious,
                                   listOfValues: ["Yes", "No" ,"-"]))
        
        
        basicRows.append(TextViewRow(title: "Note",
                                     kvcKey: "note",
                                     value: rescued.note ?? "-"))

//        basicRows.append(ButtonRow(title: "Delete",
//                                   image: UIImage(systemName: "trash")!,
//                                   tintColor: .systemRed,
//                                   actionTag: "deleteTag"))
//
    
    }

    override init() { fatalError("not implemented") }
}
