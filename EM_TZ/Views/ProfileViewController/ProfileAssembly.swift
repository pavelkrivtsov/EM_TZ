//
//  ProfileAssembly.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 25.03.2023.
//

import UIKit

class ProfileAssembly {
    
    static func assemble(_ coordinator: AppCoordinatorProtocol) -> UIViewController {
        let tableView = UITableView()
        let tableManager = ProfileTableManager(tableView: tableView)
        let viewModel = ProfileViewModel(coordinator: coordinator, tableManager: tableManager)
        let view = ProfileViewCotroller(viewModel: viewModel, tableView: tableView)
        return view
    }
}
