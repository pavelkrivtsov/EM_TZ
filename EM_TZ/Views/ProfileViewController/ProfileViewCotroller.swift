//
//  ProfileViewCotroller.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 25.03.2023.
//

import UIKit
import SnapKit

final class ProfileViewCotroller: UIViewController {
    
    private let viewModel: ProfileViewModel
    private let tableView: UITableView
    
    init(viewModel: ProfileViewModel, tableView: UITableView) {
        self.viewModel = viewModel
        self.tableView = tableView
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        tableView.frame = self.view.bounds
        viewModel.fillTheTable()
    
        let profileTitleLabel = UILabel()
        profileTitleLabel.text = "Profile"
        profileTitleLabel.font = .init(name: "Montserrat-Bold", size: 15)
        navigationItem.titleView = profileTitleLabel
    }

}
