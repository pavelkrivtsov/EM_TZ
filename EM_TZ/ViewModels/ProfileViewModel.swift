//
//  ProfileViewModel.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 25.03.2023.
//

import UIKit


final class ProfileViewModel {
    
    private let coordinator: AppCoordinatorProtocol
    private var tableManager: ProfileTableManager
    
    init(coordinator: AppCoordinatorProtocol, tableManager: ProfileTableManager) {
        self.coordinator = coordinator
        self.tableManager = tableManager
    }
    
    func fillTheTable() {
        
        let cellModels: [CellType] = {
            return [
                .avatarCell,
                
                    .labelCell(label: CellLabelProperties(title: "Satria Adhi Pradana")),
                
                    .buttonCell,
                
                    .arrowRightCell(image: CellImageProperties(image: .init(named: "cardIcon")!),
                                    label: CellLabelProperties(title: "Trade store")),
                
                    .arrowRightCell(image: CellImageProperties(image: .init(named: "cardIcon")!),
                                    label: CellLabelProperties(title: "Payment method")),
                
                
                    .withoutArrowRightCell(tapAction: CellGeneralProperties(),
                                           image: CellImageProperties(image: .init(named: "cardIcon")!),
                                           label: CellLabelProperties(title: "Balance"),
                                           secondLabel: CellLabelProperties(title: "$ \(1593)")),
                
                    .arrowRightCell(image: CellImageProperties(image: .init(named: "cardIcon")!),
                                    label: CellLabelProperties(title: "Trade history")),
                
                    .arrowRightCell(image: CellImageProperties(image: .init(named: "arrowsIcon")!),
                                    label: CellLabelProperties(title: "Restore Purchase")),
                
                    .withoutArrowRightCell(tapAction: CellGeneralProperties(),
                                           image: CellImageProperties(image: .init(named: "questionIcon")!),
                                           label: CellLabelProperties(title: "Help"),
                                           secondLabel: CellLabelProperties()),
                
                    .withoutArrowRightCell(tapAction: CellGeneralProperties(tapAction: {
                        self.logOut()
                    }),
                                           image: CellImageProperties(image: .init(named: "logoutIcon")!),
                                           label: CellLabelProperties(title: "Log out"),
                                           secondLabel: CellLabelProperties())
            ]
        }()
        self.tableManager.fillViewModels(viewModels: cellModels)
    }
    
    func logOut() {
        coordinator.showSingInScreen()
    }
}
