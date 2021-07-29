//
//  CustomModalViewController.swift
//  lesson5
//
//  Created by Veronika Shadlovskaya on 28.07.2021.
//

import UIKit
import SnapKit

class AddPersonViewController: UIViewController, AnyView {
    var presenter: AnyPresenter?
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()

    lazy var cancellButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отмена", for: .normal)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        return button
    }()

    lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить", for: .normal)
        button.addTarget(self, action: #selector(addPerson), for: .touchUpInside)
        return button
    }()
   
    lazy var addImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Изменить фото", for: .normal)
        return button
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 75
        imageView.image = UIImage(named: "personDefaultImage")
        return imageView
    }()

    var collectionView: UICollectionView!
    
    let defaultHeight: CGFloat = 810
    let cells = Helper.app.addPersonCells
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
      
    func setupView() {
        let colletionViewFrame =  CGRect(x: 0, y: 300, width: self.view.frame.width,  height: 180)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        collectionView = UICollectionView(frame: colletionViewFrame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(CellWithInput.self, forCellWithReuseIdentifier: CellWithInput.reusableIdentifier)
        collectionView.register(CellWithPicker.self, forCellWithReuseIdentifier: CellWithPicker.reusableIdentifier)
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    func update(with persons: [Person]) {}
    func setupConstraints() {
        view.addSubview(containerView)
        view.addSubview(cancellButton)
        view.addSubview(addButton)
        view.addSubview(collectionView)
        view.addSubview(imageView)
        view.addSubview(addImageButton)
        
        cancellButton.snp.makeConstraints { make in
            make.leading.top.equalTo(containerView).inset(10)
        }
        addButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(containerView).inset(10)
        }
        containerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(defaultHeight)
        }
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(containerView.snp.top).inset(250)
        }
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(150)
            make.top.equalTo(containerView.snp.top).inset(60)
            make.centerX.equalToSuperview()
        }
        addImageButton.snp.makeConstraints { make in
            make.bottom.equalTo(addImageButton.snp.bottom).inset(5)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func closeView(){
        self.dismiss(animated: true)
    }
    
    @objc func addPerson(){
        let visibleCells = collectionView.visibleCells
        let name = (visibleCells[0] as! CellWithInput).textField.text ?? ""
        let person = Person(name: name)
        (presenter as? PersonsPresenter)?.addNewPerson(person)
        self.dismiss(animated: true)
    }
}

extension AddPersonViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //var cellView = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellWithInput
        
        let cell = cells[indexPath.item]
      
        switch cell{
        case .textInput(let labelText, let placeholder):
            let cellView = collectionView.dequeueReusableCell(withReuseIdentifier: CellWithInput.reusableIdentifier, for: indexPath) as! CellWithInput
            cellView.label.text = labelText
            cellView.textField.placeholder = placeholder
            return cellView
        case .dateInput(let labelText):
            let cellView = collectionView.dequeueReusableCell(withReuseIdentifier: CellWithPicker.reusableIdentifier, for: indexPath) as! CellWithPicker
            cellView.cellWithInput.label.text = labelText
            return cellView
          
        default:
            let cellView = collectionView.dequeueReusableCell(withReuseIdentifier: CellWithInput.reusableIdentifier, for: indexPath) as! CellWithInput
            cellView.label.text = "Label"
            return cellView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
}
