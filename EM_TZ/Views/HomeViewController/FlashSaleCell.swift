//
//  FlashSaleCell.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 22.03.2023.
//

import UIKit
import SnapKit

final class FlashSaleCell: UICollectionViewCell {
    
    static var reuseId = "FlashSaleCell"
    
    private var category = UILabel()
    private var name = UILabel()
    private var price = UILabel()
    private var discount = UILabel()
//    private var imageURL = String()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .green
        
        contentView.addSubview(category)
        category.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(7)
            make.bottom.equalToSuperview().inset(46)
            make.top.equalToSuperview().inset(91)
        }
        category.backgroundColor = .blue
        
        contentView.addSubview(name)
        name.snp.makeConstraints { make in
            make.top.equalTo(category.snp.bottom).inset(6.32)
            make.leading.equalToSuperview().inset(7)
            make.bottom.equalToSuperview().inset(30.54)
        }
        name.backgroundColor = .gray
        
        contentView.addSubview(price)
        price.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(7)
        }
        price.backgroundColor = .red
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FlashSaleCell {
    func configure(item: ProductsElement) {
        self.category.text = item.category
        self.name.text = item.name
        self.price.text = String(item.price)
    }
}
