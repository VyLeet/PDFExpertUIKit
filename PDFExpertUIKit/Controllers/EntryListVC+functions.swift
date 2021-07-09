//
//  EntryListVC+functions.swift
//  PDFExpertUIKit
//
//  Created by Nazariy Vysokinskyi on 06.07.2021.
//

import UIKit

// MARK: - HELPER FUNCTIONS

extension EntryListVC {
    // MARK: - NAVIGATION BAR BUTTONS
    func configureNavBarItems() {
        let layoutButton = UIBarButtonItem(image: UIImage(systemName: layoutType.rawValue), style: .plain, target: self, action: #selector(changeLayout))
        
        navigationItem.rightBarButtonItem = layoutButton
    }
    
    @objc func changeLayout() {
        if layoutType == .table {
            layoutType = .collection
            
            tableView.removeFromSuperview()
            configureCollectionView()
        } else {
            layoutType = .table
            
            collectionView.removeFromSuperview()
            configureTableView()
        }
    }
    
    func configureTableView() {
        tableView.frame = view.bounds
        
        view.addSubview(tableView)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        
        tableView.rowHeight = 50
    }
    
    func configureCollectionView() {
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
    }
    
    // MARK: - SET DELEGATES
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setCollectionViewDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
