//
//  SignInHeader.swift
//  lesson5
//
//  Created by Veronika Shadlovskaya on 27.07.2021.
//

import UIKit

class SignInHeader: UIView {
    var title: UILabel = {
        let title = UILabel(frame: CGRect(x: 100 , y: 150, width: 200, height: 80))
        title.textAlignment = .center
        title.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        title.textColor = UIColor(red: 0.6, green: 0.6, blue: 1, alpha: 1)
        title.layer.borderWidth = 1
        title.text = "BIRTHDAY REMINDER"
        return title
      }()
  
    var subtitle: UILabel = {
        let label = UILabel(frame: CGRect(x: 20 , y: 250, width: 200, height: 50))
        label.text = "Sign In"
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return label
      }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
      }
      
      required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureContents()
      }
      
      private func configureContents() {
        addSubview(self.title)
        addSubview(self.subtitle)
      }
}
