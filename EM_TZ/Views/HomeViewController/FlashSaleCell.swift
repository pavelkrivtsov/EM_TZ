//
//  FlashSaleCell.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 22.03.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class FlashSaleCell: UICollectionViewCell {
    
    static var reuseId = "FlashSaleCell"
    
    private var categoryLabel = UILabel()
    private var nameLabel = UILabel()
    private var priceLabel = UILabel()
    private var imageView = UIImageView()
    private var addToCartButton = UIButton()
    private var addToFavouritesButton = UIButton()
    private var marketImage = UIImageView(image: .init(named: "marketImage"))
    private var discountLabel = UILabel()
    
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
            make.width.height.equalTo(35)
            make.trailing.equalToSuperview().inset(4)
            make.bottom.equalToSuperview().inset(7)
        }
        addToCartButton.setImage(.add, for: .normal)
        addToCartButton.backgroundColor = .red
        
        contentView.addSubview(addToFavouritesButton)
        addToFavouritesButton.snp.makeConstraints { make in
            make.width.height.equalTo(28)
            make.trailing.equalTo(addToCartButton.snp.leading).offset(-5)
            make.centerY.equalTo(addToCartButton.snp.centerY)
        }
        addToFavouritesButton.setImage(.actions, for: .normal)
        addToFavouritesButton.backgroundColor = .blue
        
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(16)
            make.trailing.equalTo(addToFavouritesButton.snp.leading).offset(-5)
            make.height.equalTo(14)
        }
        priceLabel.backgroundColor = .red
        priceLabel.font = .init(name: "Montserrat-Bold", size: 14)
        priceLabel.textColor = .white
        
        contentView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.width.equalTo(45)
            make.height.equalTo(17)
            make.bottom.equalToSuperview().inset(83)
            make.top.equalToSuperview().inset(121)
        }
        categoryLabel.backgroundColor = .lightGray
        categoryLabel.layer.cornerRadius = 5
        categoryLabel.clipsToBounds = true
        categoryLabel.font = .init(name: "Montserrat-Bold", size: 10)
        categoryLabel.textAlignment = .center
        
        contentView.addSubview(marketImage)
        marketImage.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.top.leading.equalToSuperview().inset(7.5)
        }
        
        contentView.addSubview(discountLabel)
        discountLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(7)
            make.width.equalTo(48)
            make.height.equalTo(18)
        }
        discountLabel.backgroundColor = .red
        discountLabel.layer.cornerRadius = 10
        discountLabel.clipsToBounds = true
        discountLabel.font = .init(name: "Montserrat-Medium", size: 10)
        discountLabel.textAlignment = .center
        discountLabel.textColor = .white

        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).inset(-6.32)
            make.leading.equalToSuperview().inset(10)
            make.width.equalTo(priceLabel.snp.width)
        }
        nameLabel.backgroundColor = .darkGray
        nameLabel.font = .init(name: "Montserrat-Bold", size: 12)
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
        self.discountLabel.text = ""
        self.imageView.image = nil
    }
}

extension FlashSaleCell {
    func configure(item: ProductsElement) {
        guard let url = URL(string: item.imageURL),
              let discount = item.discount else {
            print("FlashSaleCell configure error")
            return
        }
        self.categoryLabel.text = item.category
        self.nameLabel.text = item.name
        let doubleStr = String(format: "%.2f", item.price)
        self.priceLabel.text = "$ \(doubleStr)"
        self.discountLabel.text = "\(discount)% off"
        self.imageView.kf.setImage(with: url)
    }
}
