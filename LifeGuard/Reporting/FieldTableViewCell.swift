//
//  FieldTableViewCell.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-02-01.
//

import UIKit



//protocol FieldTableViewCellDelegate {
//    func getTextField(getText: String)
//}

class FieldTableViewCell: UITableViewCell {
    
//    var fieldTableViewCellDelegate: FieldTableViewCellDelegate!
//
//    var textFieldEnd: String = ""
//
    static let identifier = "FieldTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "FieldTableViewCell", bundle: nil)
    }
    
    @IBOutlet var field: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        field.delegate = self
        //        field.placeholder = "type somthing..."
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

//extension FieldTableViewCell: UITextFieldDelegate {
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        textFieldEnd = textField.text!
//        print(textFieldEnd)
//        // send text via delegate
//        fieldTableViewCellDelegate.getTextField(getText: "hej atlal")
//
//
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textFieldEnd = textField.text!
//        print(textFieldEnd)
//        // send text via delegate
////        fieldTableViewCellDelegate.getTextField(getText: "hel atlal")
//
//        textField.resignFirstResponder()
//
//        //        print("\(textField.text ?? "")")
//
//        return true
//
//   }
//}
