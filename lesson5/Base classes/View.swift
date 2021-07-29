//
//  View.swift
//  lesson5
//
//  Created by Veronika Shadlovskaya on 29.07.2021.
//

import Foundation

protocol AnyView {
    var presenter: AnyPresenter? { get set }
}
