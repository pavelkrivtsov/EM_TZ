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
        var configuration = UIButton.Configuration.bordered()
        configuration.baseBackgroundColor = UIColor.buttonColor
        configuration.baseForegroundColor = .white
        configuration.title = "Upload item"
        configuration.titleAlignment = .center
        configuration.attributedTitle?.font = .init(name: "Montserrat-Bold", size: 15)
        configuration.image = .init(named: "custom.square.and.arrow.up")
        configuration.cornerStyle = .dynamic
        button.configuration = configuration
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
