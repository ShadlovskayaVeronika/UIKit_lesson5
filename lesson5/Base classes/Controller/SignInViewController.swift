//
//  ViewController.swift
//  lesson5
//
//  Created by Veronika Shadlovskaya on 26.07.2021.
//

import UIKit

class SignInViewController: UIViewController {

    var collectionView: UICollectionView!
    var header: SignInHeader!
    var footer: SignInFooter!
    
    let cells = Helper.app.signInCells
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
    }
    
    func configureContents() {
        let colletionViewFrame =  CGRect(x: 0, y: 300, width: self.view.frame.width,  height: 180)
        collectionView = UICollectionView(frame: colletionViewFrame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(CellWithInput.self, forCellWithReuseIdentifier: "cell")
        
        header = SignInHeader(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300))
        footer = SignInFooter(frame: CGRect(x: 0, y: 480, width: self.view.frame.width, height: 300))
        footer.signInButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(header)
        self.view.addSubview(collectionView)
        self.view.addSubview(footer)
    }
    
    @objc func buttonAction() {
        let vc = Router.personsListView
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SignInViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let(type , label, placeholder) = cells[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellWithInput
        cell.label.text = label
        cell.textField.placeholder = placeholder
                
        if type == .passwordInput{
            cell.textField.isSecureTextEntry = true
            
            let overlayButton = UIButton(type: .custom)
            let eyeImage = UIImage(systemName: "eye")
            overlayButton.tintColor = .lightGray
            overlayButton.setImage(eyeImage, for: .normal)
            overlayButton.sizeToFit()
                    
            cell.textField.rightView = overlayButton
            cell.textField.rightViewMode = .always
        }
        
        return cell
    }
    
}
    

