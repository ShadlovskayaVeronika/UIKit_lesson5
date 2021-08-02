//
//  Router.swift
//  lesson5
//
//  Created by Veronika Shadlovskaya on 29.07.2021.
//

import Foundation
import UIKit

protocol AnyRouter {
    static func start()
}

class Router: AnyRouter {
    static var personsListView: AnyView & UIViewController  = PersonsListViewController(collectionViewLayout: UICollectionViewFlowLayout())
    static var addPersonView: AnyView & UIViewController  = AddPersonViewController()
    
    static func start() {
        var presenter: AnyPresenter = PersonsPresenter()
        var interactor: AnyInteractor = PersonsInteractor()

        personsListView.presenter = presenter
        addPersonView.presenter = presenter
        interactor.presenter = presenter
        presenter.view = personsListView
        presenter.view = personsListView
        interactor.getPersons()
        presenter.interactor = interactor
    }
}
