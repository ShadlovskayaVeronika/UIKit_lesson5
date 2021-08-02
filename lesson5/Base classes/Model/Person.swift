//
//  Person.swift
//  lesson5
//
//  Created by Veronika Shadlovskaya on 26.07.2021.
//

import Foundation

class Person {
    let name: String
    let birthDate: Date
    let age: Int
    let sex: Sex
    let instagram: String
    
    init(name: String = "",
         birthDate: String = "",
         age: Int = 20,
         sex: Sex = .female,
         instagram: String = "") {
        self.name = name
        //self.birthDate = birthDate
        self.age = age
        self.sex = sex
        self.instagram = instagram
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.birthDate = dateFormatter.date(from: birthDate) ?? Date()
    }
}

enum Sex: String, CaseIterable {
    case female = "Женский"
    case male = "Мужской"
}
