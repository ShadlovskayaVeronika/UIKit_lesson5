//
//  SignInFooter.swift
//  lesson5
//
//  Created by Veronika Shadlovskaya on 27.07.2021.
//

import UIKit

class SignInFooter: UIView {
    let signInButton = UIButton(frame: CGRect(x: 50, y: 70, width: 320, height: 50))
    let faceIdSwitch = UISwitch()
    let faceIdLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 150, y: 0, width: 200, height: 30))
        label.text = "Вход по FaceID?"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
      }
      
      //initWithCode to init view from xib or storyboard
      required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureContents()
      }
      
      //common func to init our view
      private func configureContents() {
        addSubview(signInButton)
        addSubview(faceIdSwitch)
        addSubview(faceIdLabel)
        
        signInButton.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 1, alpha: 1)
        signInButton.setTitle("Войти", for: .normal)
       
        faceIdSwitch.translatesAutoresizingMaskIntoConstraints = false
        faceIdSwitch.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: -80).isActive = true
      }
    
}
