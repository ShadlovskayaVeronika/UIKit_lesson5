//
//  CellWithPersonInfo.swift
//  lesson5
//
//  Created by Veronika Shadlovskaya on 28.07.2021.
//

import UIKit
import SnapKit

class CellWithPersonInfo: UICollectionViewCell {
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let daysToBirthdayLabel = UILabel()
    let additionalInfoLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        self.backgroundColor = .white
        
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(daysToBirthdayLabel)
        addSubview(additionalInfoLabel)
       
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
        
        daysToBirthdayLabel.textColor = .lightGray
        daysToBirthdayLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        
        additionalInfoLabel.textColor = .lightGray
        additionalInfoLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.image = UIImage(named: "personDefaultImage")
    
        imageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(5)
            make.height.width.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.equalTo(imageView.snp.trailing).inset(-15)
        }
        
        daysToBirthdayLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(5)
            make.top.equalToSuperview().inset(15)
        }
        additionalInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-5)
            make.leading.equalTo(imageView.snp.trailing).inset(-15)
        }
            
    }
}
 
