//
//  FamilyViewController.swift
//  InfoUser
//
//  Created by Павел Заруцков on 11.06.2021.
//

import UIKit

protocol AnswerCellUITextFieldChanged {
    func didAnswerTextFieldChanged(childId: Int, childName: String, childAge: String)
}

class FamilyViewController: UIViewController {
    
    @IBOutlet weak var childTableView: UITableView!
    @IBOutlet weak var addChildButtonDidPressed: UIButton!
    
    var childNameArray = [String]()
    var childAgeArray = [String]()
    var childCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        childTableView.delegate = self
        childTableView.dataSource = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func deleteChildCell(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: childTableView)
        guard let indexpath = childTableView.indexPathForRow(at: point) else {return}
        childNameArray.remove(at: indexpath.row)
        childAgeArray.remove(at: indexpath.row)
        childCount -= 1
        hideAddChildButton()
        childTableView.reloadData()
    }
    
    @IBAction func addChildButton(_ sender: UIButton) {
        childNameArray.append("")
        childAgeArray.append("")
        childCount += 1
        hideAddChildButton()
        childTableView.reloadData()
        
    }
    
    func hideAddChildButton() {
        if childCount == 5 {
            addChildButtonDidPressed.isHidden = true
        } else {
            addChildButtonDidPressed.isHidden = false
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension FamilyViewController: UITableViewDelegate, UITableViewDataSource, AnswerCellUITextFieldChanged {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChildTableViewCell
        
        cell.fioChild.text = childNameArray[indexPath.row]
        cell.ageChild.text = childAgeArray[indexPath.row]
        cell.childId = indexPath.row
        cell.nameAndAgeFieldsChangled = self
        cell.configureCell()
        return cell
    }
    
    func didAnswerTextFieldChanged(childId: Int, childName: String, childAge: String) {
        childNameArray[childId] = childName
        childAgeArray[childId] = childAge
    }
}

