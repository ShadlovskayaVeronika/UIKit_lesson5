//
//  Helper.swift
//  lesson5
//
//  Created by Veronika Shadlovskaya on 29.07.2021.
//

import Foundation

class Helper {
    static var app: Helper = {
        return Helper()
    }()
    
    let signInCells: [CellType] = [.textInput("Email","email"), .passwordInput]
    let addPersonCells: [CellType] = [.textInput("Имя", "Введите имя"), .dateInput("Дата рождения"),
                                      .numericInput("Возраст"), .textInput("Instagram", "Добавить")]
}
