//
//  ChildTableViewCell.swift
//  InfoUser
//
//  Created by Павел Заруцков on 11.06.2021.
//

import UIKit

class ChildTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    var childId: Int?
    var nameAndAgeFieldsChangled: AnswerCellUITextFieldChanged?
    
    @IBOutlet weak var fioChild: UITextField! {
        didSet {
            fioChild.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var ageChild: UITextField! {
        didSet {
            ageChild.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
        }
    }
    
    func configureCell() {
        self.fioChild.delegate = self
        self.ageChild.delegate = self
    }
    
    @objc func textFieldValueChanged(_ sender: UITextView) {
        nameAndAgeFieldsChangled?.didAnswerTextFieldChanged(childId: childId!, childName: fioChild.text ?? "", childAge: ageChild.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        nameAndAgeFieldsChangled?.didAnswerTextFieldChanged(childId: childId!, childName: fioChild.text ?? "", childAge: ageChild.text ?? "")
        
        return false
    }
}
