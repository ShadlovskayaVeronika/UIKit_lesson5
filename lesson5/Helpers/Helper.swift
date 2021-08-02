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
    
    let signInCells: [(CellType, String, String)] = [(.textInput, "Email", "email"), (.passwordInput, "Пароль", "пароль")]
    let addPersonCells: [(CellType, String, String)] = [(.textInput, "Имя", "Введите имя"), (.dateInput, "Дата рождения", ""),
                                      (.enumInput, "Пол", ""), (.numericInput, "Возраст", ""),
                                      (.textInput, "Instagram", "Добавить")]
}
