//
//  HomeViewController.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 16.03.2023.
//

import UIKit

class HomeViewController: UIViewController {

    private let networkService = NetworkService()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private var sections = [Section]()
    private var latest = [LatestElement]()
    private var flashSale = [FlashSaleElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainWhite
        
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(LatestCell.self, forCellWithReuseIdentifier: LatestCell.reuseId)
        collectionView.register(FlashSaleCell.self, forCellWithReuseIdentifier: FlashSaleCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        networkService.fetchLatest { [weak self] latest in
            guard let self = self else { return }
            var section = Section(header: "Latest", items: [])
            for item in latest {
                let product = ProductsElement(category: item.category,
                                              name: item.name,
                                              price: item.price,
                                              discount: nil,
                                              imageURL: item.imageURL)
                section.items.append(product)
            }
            self.sections.append(section)
            self.collectionView.reloadData()
        }
        
        networkService.fetchFlashSale { [weak self] flashSale in
            guard let self = self else { return }
            var section = Section(header: "Flash Sale", items: [])
            for item in flashSale {
                let product = ProductsElement(category: item.category,
                                              name: item.name,
                                              price: item.price,
                                              discount: item.discount,
                                              imageURL: item.imageURL)
                section.items.append(product)
            }
            self.sections.append(section)
            self.collectionView.reloadData()
        }
    }
}

//  MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0,
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LatestCell.reuseId,
                                                         for: indexPath) as? LatestCell {
            let section = sections[indexPath.section]
            let item = section.items[indexPath.item]
            cell.configure(item: item)
            return cell
        }
        
        if indexPath.section == 1,
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlashSaleCell.reuseId,
                                                         for: indexPath) as? FlashSaleCell {
            let section = sections[indexPath.section]
            let item = section.items[indexPath.item]
            cell.configure(item: item)
            return cell
        }
        return UICollectionViewCell()
    }
}

//  MARK: - CompositionalLayout
extension HomeViewController {
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) ->
            NSCollectionLayoutSection in
            if sectionIndex == 0 {
                return self.createLatestSection()
            } else {
                return self.createFlashSaleSection()
            }
        }
        return layout
    }
    
    private func createLatestSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(114),
                                              heightDimension: .absolute(149))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(1),
                                               heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 11, bottom: 0, trailing: 11)
        section.interGroupSpacing = CGFloat(12)
        section.orthogonalScrollingBehavior = .continuous
        //        TODO: - Create Header
        return section
    }
    
    private func createFlashSaleSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(174),
                                              heightDimension: .absolute(221))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(1),
                                               heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 11, bottom: 0, trailing: 11)
        section.interGroupSpacing = CGFloat(12)
        section.orthogonalScrollingBehavior = .continuous
        //        TODO: - Create Header
        return section
    }
}
