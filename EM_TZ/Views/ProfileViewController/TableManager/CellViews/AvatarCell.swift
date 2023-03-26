//
//  AvatarCell.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 26.03.2023.
//

import UIKit
import SnapKit

final class AvatarCell: UITableViewCell {
    
    private let avatarView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(avatarView)
        avatarView.snp.makeConstraints { make in
            make.centerX.top.equalToSuperview()
            make.height.width.equalTo(60)
        }
        avatarView.image = .init(named: "barButtonProfileIcon")
        avatarView.contentMode = .scaleAspectFit
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(avatarView.snp.centerX)
            make.top.equalTo(avatarView.snp.bottom).inset(-8.5)
            make.bottom.equalToSuperview()
        }
        titleLabel.font = .init(name: "Montserrat-Regular", size: 10)
        titleLabel.text = "Change photo"
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
