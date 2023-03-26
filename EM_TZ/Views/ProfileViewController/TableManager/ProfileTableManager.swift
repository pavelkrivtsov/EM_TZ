//
//  ProfileTableManager.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 25.03.2023.
//

import UIKit

protocol ProfileTableManagerOutput {
    func fillViewModels(viewModels: [CellType])
    func showScreen(tableView: UITableView,
                    cellForRowAt indexPath: IndexPath,
                    viewModels: [CellType]) -> UITableViewCell
}

final class ProfileTableManager: NSObject {
    
    private var tableView: UITableView
    private var viewModels = [CellType]()
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        self.tableView.separatorStyle = .none
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    private func registerForCells(viewModels: [CellType]) {
        let keys: Set<String> = Set(viewModels.map({ $0.cellsId }))
        keys.forEach { key in
            let objectClass: AnyClass?  = NSClassFromString( "EM_TZ." + key)
            guard let classType = objectClass as? UITableViewCell.Type else {
                return
            }
            tableView.register(classType, forCellReuseIdentifier: key)
        }
    }
}

extension ProfileTableManager: ProfileTableManagerOutput {
    
    
    func fillViewModels(viewModels: [CellType]) {
        self.viewModels = viewModels
        registerForCells(viewModels: viewModels)
        tableView.reloadData()
    }
    
    func showScreen(tableView: UITableView, cellForRowAt indexPath: IndexPath, viewModels: [CellType]) -> UITableViewCell {
        let model = viewModels[indexPath.row]
        
        switch model {
        case .labelCell(label: _):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: model.cellsId,
                                                           for: indexPath)
                    as? LabelCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.cellConfiguration(model: model)
            return cell
            
        case .buttonCell:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: model.cellsId,
                                                           for: indexPath)
                    as? ButtonCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
            
        case .arrowRightCell(image: _, label: _):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: model.cellsId,
                                                           for: indexPath)
                    as? ArrowRightCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.cellConfiguration(model: model)
            return cell
            
        case .withoutArrowRightCell(tapAction: _, image: _, label: _, secondLabel: _):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: model.cellsId,
                                                           for: indexPath)
                    as? WithoutArrowRightCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.cellConfiguration(model: model)
            return cell
            
        case .avatarCell:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: model.cellsId,
                                                           for: indexPath)
                    as? AvatarCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension ProfileTableManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        showScreen(tableView: tableView, cellForRowAt: indexPath, viewModels: viewModels)
    }
}

extension ProfileTableManager: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = viewModels[indexPath.row]
        model.cellAction?.tapAction?()
    }
}
