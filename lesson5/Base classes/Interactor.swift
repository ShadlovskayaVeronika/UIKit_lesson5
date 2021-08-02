//
//  Interactor.swift
//  lesson5
//
//  Created by Veronika Shadlovskaya on 29.07.2021.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    func getPersons()
    func addPerson(_ person: Person)
}

class PersonsInteractor: AnyInteractor {
    static var interactor: PersonsInteractor = {
        return PersonsInteractor()
    }()
  
    var presenter: AnyPresenter?
    var persons: [Person] = [Person(name: "Carl", birthDate:"25/06/1998", age: 30, sex: .male, instagram: "@carl")]
   
    func getPersons() {
        self.presenter?.interactorChangedPersonsList(to: persons)
    }
    
    func addPerson(_ person: Person) {
        persons.append(person)
        self.presenter?.interactorChangedPersonsList(to: persons)
    }
    init(){}
}
