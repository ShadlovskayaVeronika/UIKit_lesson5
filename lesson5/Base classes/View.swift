//
//  View.swift
//  lesson5
//
//  Created by Veronika Shadlovskaya on 02.08.2021.
//

import Foundation

protocol AnyView {
    var presenter: AnyPresenter? { get set }
}
