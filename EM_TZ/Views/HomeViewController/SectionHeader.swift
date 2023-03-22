//
//  SectionHeader.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 22.03.2023.
//

import UIKit
import SnapKit

final class SectionHeader: UICollectionReusableView {
    
    static let reuseId = "SectionHeader"
    
    private var categoryName = UILabel()
    private var viewAllButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .gray
        
        addSubview(categoryName)
        categoryName.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.height.equalTo(16)
        }
        categoryName.font = .init(name: "Montserrat-Medium", size: 16)
//        categoryName.backgroundColor = .darkGray
        
        addSubview(viewAllButton)
        viewAllButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.height.equalTo(12)
        }
        viewAllButton.setTitle("View all", for: .normal)
        viewAllButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 12)
        viewAllButton.tintColor = UIColor.tabBarItemAccent
//        viewAllButton.backgroundColor = .red
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SectionHeader {
    func configure(name: String) {
        categoryName.text = name
    }
}
