//
//  LatestCell.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 22.03.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class LatestCell: UICollectionViewCell {
    
    static let reuseId = "LatestCell"
    
    private var categoryLabel = UILabel()
    private var nameLabel = UILabel()
    private var priceLabel = UILabel()
    private var addToCartButton = UIButton()
    private var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .gray
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(addToCartButton)
        addToCartButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(5)
            make.height.width.equalTo(20)
        }
//        addButton.backgroundColor = .red
        addToCartButton.setImage(.add, for: .normal)
        
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(7.37)
            make.bottom.equalToSuperview().inset(7.06)
            make.trailing.equalTo(addToCartButton.snp.leading).inset(-5)
        }
        priceLabel.backgroundColor = .red
        priceLabel.font = .init(name: "Montserrat-Bold", size: 10)
        priceLabel.textColor = .white
        
        contentView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(7)
            make.bottom.equalTo(priceLabel.snp.top).inset(-32.48)
            make.height.equalTo(12)
            make.width.equalTo(35)
        }
        categoryLabel.backgroundColor = .lightGray
        categoryLabel.layer.cornerRadius = 5
        categoryLabel.clipsToBounds = true
        categoryLabel.font = .init(name: "Montserrat-Bold", size: 6)
        categoryLabel.textAlignment = .center
//        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).inset(-6)
            make.leading.equalToSuperview().inset(7)
//            make.bottom.equalTo(price.snp.top).inset(-5.4)
            make.width.equalTo(priceLabel.snp.width)
        }
        nameLabel.backgroundColor = .darkGray
        nameLabel.font = .init(name: "Montserrat-Bold", size: 10)
        nameLabel.numberOfLines = 0
        nameLabel.textColor = .white
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.categoryLabel.text = ""
        self.nameLabel.text = ""
        self.priceLabel.text = ""
        self.imageView.image = nil
    }
}

extension LatestCell {
    func configure(item: ProductsElement) {
        guard let url = URL(string: item.imageURL) else { return }
        self.categoryLabel.text = item.category
        self.nameLabel.text = item.name
        let doubleStr = String(format: "%.2f", item.price)
        self.priceLabel.text = "$ \(doubleStr)"
        self.imageView.kf.setImage(with: url)
    }
}
