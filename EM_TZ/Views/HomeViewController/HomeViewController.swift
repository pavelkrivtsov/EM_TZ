//
//  HomeViewController.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 16.03.2023.
//

import UIKit

class HomeViewController: UIViewController {

    let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkService.fetchLatest()
        
    }
}
