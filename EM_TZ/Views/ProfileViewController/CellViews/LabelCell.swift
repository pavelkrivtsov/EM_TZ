//
//  LabelCell.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 26.03.2023.
//

import UIKit
import SnapKit

protocol LabelCellProtocol {
    func cellConfiguration(model: CellTypeProtocol)
}

final class LabelCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(40)
        }
        titleLabel.font = .init(name: "Montserrat-Bold", size: 17)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LabelCell: LabelCellProtocol {
    
    func cellConfiguration(model: CellTypeProtocol) {
        guard let titleLabel = model.label else { return }
        self.titleLabel.text = titleLabel.title
    }
}

