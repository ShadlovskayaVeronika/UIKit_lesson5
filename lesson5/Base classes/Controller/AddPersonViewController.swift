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
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
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

    
    @objc func closeView() {
        self.dismiss(animated: true)
    }
    
    @objc func addPerson() {
        let visibleCells = collectionView.visibleCells
      
        let name = (visibleCells[0] as! CellWithInput).textField.text ?? ""
        let birthDate = (visibleCells[1] as! CellWithInput).textField.text ?? ""
        let sexRawValue = (visibleCells[2] as! CellWithInput).textField.text ?? ""
        let sex = Sex(rawValue: sexRawValue) ?? .female
        let ageStr = (visibleCells[3] as! CellWithInput).textField.text ?? "0"
        let age = Int(ageStr) ?? 0
        let instagram = (visibleCells[4] as! CellWithInput).textField.text ?? ""
       
        let person = Person(name: name, birthDate: birthDate, age: age, sex: sex, instagram: instagram)
        (presenter as? PersonsPresenter)?.addNewPerson(person)
        self.dismiss(animated: true)
    }
}

extension AddPersonViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellWithInput.reusableIdentifier, for: indexPath) as! CellWithInput
        let (type, label, placeholder) = cells[indexPath.item]
        cell.label.text = label
        cell.textField.placeholder = placeholder
        
        switch type{
        case .textInput:
            break
        case .dateInput:
            createDatePicker(for: cell.textField, tag: indexPath.item)
            cell.label.text = label
        default:
            createToolbar(for: cell.textField)
            let picker = UIPickerView()
            cell.textField.inputView = picker
            picker.tag = indexPath.item
            picker.dataSource = self
            picker.delegate = self
        }
       
        return cell
    }
    
    func createToolbar(for textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: nil,
            action: #selector(doneAction))
        toolbar.setItems([doneButton], animated: true)
        textField.inputAccessoryView = toolbar
    }
    
    func createDatePicker(for textField: UITextField, tag: Int){
        var datePicker = UIDatePicker()
        datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
        datePicker.addTarget(self, action: #selector(dateChanged), for: .allEvents)
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        datePicker.tag = tag
        textField.inputView = datePicker
        createToolbar(for: textField)
    }
    
    @objc func doneAction() {
        view.endEditing(true)
    }
    @objc func selectionChanged(sender: UIPickerView) {
        
    }
    @objc func dateChanged(sender: UIDatePicker) {
        let visibleCells = collectionView.visibleCells
        let cell = visibleCells[sender.tag] as! CellWithInput
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        cell.textField.text = dateFormatter.string(from: sender.date)
    }
}
extension AddPersonViewController: UIPickerViewDataSource, UIPickerViewDelegate {
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch cells[pickerView.tag].0{
        case .numericInput:
            return 100
        case .enumInput:
            return Sex.allCases.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch cells[pickerView.tag].0{
        case .numericInput:
            return String(row)
        case .enumInput:
            return Sex.allCases[row].rawValue
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let visibleCells = collectionView.visibleCells
        let cell = visibleCells[pickerView.tag] as! CellWithInput
        cell.textField.text = self.pickerView(pickerView, titleForRow: row, forComponent: component)
    }
}

extension AddPersonViewController: UICollectionViewDelegateFlowLayout {
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
