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
    private var latest = [LatestElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainWhite
        
        networkService.fetchLatest { [weak self] latest in
            guard let self = self else { return }
            self.latest = latest
            self.collectionView.reloadData()
        }

        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.collectionViewLayout = createLatestSection()
        collectionView.register(LatestCell.self, forCellWithReuseIdentifier: LatestCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        latest.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LatestCell.reuseId,
                                                      for: indexPath) as? LatestCell {
            let item = latest[indexPath.item]
            cell.configure(item: item)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension HomeViewController {
    
    private func createLatestSection() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(114),
                                              heightDimension: .absolute(149))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(1),
                                               heightDimension: .fractionalHeight(1))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 11, bottom: 0, trailing: 11)
        section.interGroupSpacing = CGFloat(12)
        section.orthogonalScrollingBehavior = .continuous
        
//        TODO: - Create Header
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
