//
//  WithoutArrowRightCell.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 26.03.2023.
//

import UIKit
import SnapKit

protocol WithoutArrowRightCellProtocol {
    func cellConfiguration(model: CellTypeProtocol)
}

final class WithoutArrowRightCell: UITableViewCell {
    
    private let leftImageView = UIImageView()
    private let titleLabel = UILabel()
    private let rightLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(leftImageView)
        leftImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(32)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(40)
            make.top.bottom.equalToSuperview().inset(10)
        }
        leftImageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(rightLabel)
        rightLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(45)
        }
        rightLabel.font = .init(name: "Montserrat-Regular", size: 17)
        rightLabel.textAlignment = .right
        rightLabel.numberOfLines = 1
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftImageView.snp.trailing).inset(-16)
            make.trailing.equalTo(rightLabel.snp.leading).inset(-16)
            make.centerY.equalToSuperview()
        }
        titleLabel.font = .init(name: "Montserrat-Regular", size: 17)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WithoutArrowRightCell: WithoutArrowRightCellProtocol {
    
    func cellConfiguration(model: CellTypeProtocol) {
        guard let image = model.image,
                let titleLabel = model.label  else { return }
        self.leftImageView.image = image.image
        self.titleLabel.text = titleLabel.title
        self.rightLabel.text = model.secondLabel?.title ?? ""
    }
}

