//
//  CellWithPicker.swift
//  lesson5
//
//  Created by Veronika Shadlovskaya on 29.07.2021.
//

import UIKit

class CellWithPicker: UICollectionViewCell {
   
    static let reusableIdentifier = "CellWithPicker"
  
    var datePicker = UIDatePicker()
    let cellWithInput = CellWithInput()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        addSubview(cellWithInput)
        cellWithInput.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        var datePicker = UIDatePicker()
        datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 200))
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        cellWithInput.textField.inputView = datePicker
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.datePickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        cellWithInput.textField.inputAccessoryView = toolBar
    }
   
    @objc func datePickerDone() {
        cellWithInput.textField.resignFirstResponder()
    }

    @objc func dateChanged() {
        cellWithInput.textField.text = "\(datePicker.date)"
    }
}
