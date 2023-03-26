//
//  HomeViewController.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 16.03.2023.
//

import UIKit

final class HomeViewController: UIViewController {

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private var viewModel: HomeViewModel
    private var sections = [Section]()

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel.fetchProducts()
        bindViewModel()
        setupNavBar()
        setupCollectionView()
    }

    deinit {
        print("deinit")
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(SectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeader.reuseId)
        collectionView.register(LatestCell.self, forCellWithReuseIdentifier: LatestCell.reuseId)
        collectionView.register(FlashSaleCell.self, forCellWithReuseIdentifier: FlashSaleCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func bindViewModel() {
        viewModel.sections.bind { [weak self] sections in
            self?.sections = sections
            self?.collectionView.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0,
           let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                           withReuseIdentifier: SectionHeader.reuseId,
                                                                           for: indexPath) as? SectionHeader {
            header.configure(name: sections[indexPath.section].sectionHeaderName)
            return header
        }
        
        if indexPath.section == 1,
           let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                           withReuseIdentifier: SectionHeader.reuseId,
                                                                           for: indexPath) as? SectionHeader {
            header.configure(name: sections[indexPath.section].sectionHeaderName)
            return header
        }
        return UICollectionReusableView()
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
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 11, bottom: 22, trailing: 11)
        section.interGroupSpacing = CGFloat(12)
        section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(16))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
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
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 11, bottom: 22, trailing: 11)
        section.interGroupSpacing = CGFloat(9)
        section.orthogonalScrollingBehavior = .continuous
   
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(16))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
}

//  MARK: - NavigationController
extension HomeViewController {
    
    private func setupNavBar() {
        let image = UIImageView.init(image: .init(named: "leftItemPage1"))
        let leftBarButtonItem = UIBarButtonItem(customView: image)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.titleView = UIImageView(image: .init(named: "titlePage1"))
        
        let customView = UIImageView.init(image: .init(named: "barButtonProfileIcon"))
        let rightBarButtonItem = UIBarButtonItem(customView: customView)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        navigationItem.searchController = UISearchController()
    }
}
