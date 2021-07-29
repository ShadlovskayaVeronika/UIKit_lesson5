//
//  CellWithInput.swift
//  lesson5
//
//  Created by Veronika Shadlovskaya on 26.07.2021.
//

import UIKit

class CellWithInput: UICollectionViewCell {
   
    static let reusableIdentifier = "CellWithInput"
    let textField = UITextField()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        contentView.addSubview(textField)
        contentView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label.heightAnchor.constraint(equalToConstant: 30),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            textField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -50 )
        ])
        
        textField.borderStyle = .roundedRect
        label.textColor =  UIColor(red: 0.6, green: 0.6, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        contentView.backgroundColor = UIColor.white
    }
}
