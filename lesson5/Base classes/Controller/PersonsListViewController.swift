//
//  PersonsListViewController.swift
//  lesson5
//
//  Created by Veronika Shadlovskaya on 29.07.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class PersonsListViewController: UICollectionViewController, AnyView {
    static var personsListViewController = self
    
    var presenter: AnyPresenter? 
    var persons: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+",style: .plain, target: self, action: #selector(addNewPerson))
       
        self.clearsSelectionOnViewWillAppear = false

        self.collectionView!.register(CellWithPersonInfo.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.backgroundColor = .lightGray
    }
    
    @objc func addNewPerson(){
        let vc = Router.addPersonView
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func update(with persons: [Person]) {
        DispatchQueue.main.async {
            self.persons = persons
            self.collectionView.reloadData()
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return persons.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CellWithPersonInfo
        cell.nameLabel.text = persons[indexPath.item].name
        return cell
    }

}

extension PersonsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
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

