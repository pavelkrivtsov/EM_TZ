//
//  Coordinator.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 15.03.2023.
//

import UIKit

typealias CoordinatorHeandler = () -> Void

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var flowCompletionHeandler: CoordinatorHeandler? { get set }
    func start()
}
