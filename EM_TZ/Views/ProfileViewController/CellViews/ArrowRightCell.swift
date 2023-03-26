//
//  ImageLabelAndArrowRightCell.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 26.03.2023.
//

import UIKit
import SnapKit

protocol ArrowRightCellProtocol {
    func cellConfiguration(model: CellTypeProtocol)
}

final class ArrowRightCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let leftImageView = UIImageView()
    private let rightImageView = UIImageView(image: .init(named: "arrowRight"))
    
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
        
        contentView.addSubview(rightImageView)
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(16)
            make.width.equalTo(10.5)
            make.trailing.equalToSuperview().inset(45)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftImageView.snp.trailing).inset(-16)
            make.trailing.equalTo(rightImageView.snp.leading).inset(-16)
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

extension ArrowRightCell: ArrowRightCellProtocol {
    
    func cellConfiguration(model: CellTypeProtocol) {
        guard let titleLabel = model.label, let image = model.image else { return }
        self.titleLabel.text = titleLabel.title
        self.leftImageView.image = image.image
    }
}
