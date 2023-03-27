//
//  ButtonCell.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 26.03.2023.
//

import UIKit
import SnapKit

final class ButtonCell: UITableViewCell {
    
    private let button = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(43)
        }
        button.backgroundColor = UIColor.buttonColor
        button.setTitle("Upload item", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .init(name: "Montserrat-Bold", size: 15)
        button.setImage(.init(named: "custom.square.and.arrow.up"), for: .normal)
        button.imageEdgeInsets.right = 40
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
