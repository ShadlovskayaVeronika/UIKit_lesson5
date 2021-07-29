//
//  Presenter.swift
//  lesson5
//
//  Created by Veronika Shadlovskaya on 29.07.2021.
//

import Foundation

protocol AnyPresenter {
    //var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorChangedPersonsList(to persons: [Person])
}

class PersonsPresenter: AnyPresenter {
    var interactor: AnyInteractor?
    var view: AnyView?

    func interactorChangedPersonsList(to persons: [Person]) {
        (view as? PersonsListViewController)?.update(with: persons)
    }
     
    func addNewPerson(_ person: Person) {
        interactor?.addPerson(person)
    }
}
