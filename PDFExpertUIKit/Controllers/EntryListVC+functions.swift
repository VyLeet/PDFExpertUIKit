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
        let layoutButton = UIBarButtonItem(image: UIImage(systemName: activeLayout.rawValue), style: .plain, target: self, action: #selector(changeLayout))
        
        let reloadTable = UIBarButtonItem(image: UIImage(systemName: "arrow.2.squarepath"), style: .plain, target: self, action: #selector(reloadTable))
        
        let printChildrenButton = UIBarButtonItem(image: UIImage(systemName: "printer.fill"), style: .plain, target: self, action: #selector(printChildrenNodes))
        
        navigationItem.rightBarButtonItems = [layoutButton, reloadTable, printChildrenButton]
    }
    
    @objc func printChildrenNodes() {
        print(entryNode.description)
    }
    
    @objc func reloadTable() {
        if activeLayout == .table {
            tableView.reloadData()
        } else {
            collectionView.reloadData()
        }
    }
    
    @objc func changeLayout() {
        if activeLayout == .table {
            tableView.removeFromSuperview()
            configureCollectionView()
            
            UserDefaults.standard.setValue(false, forKey: "isTableViewActive")
        } else {
            collectionView.removeFromSuperview()
            configureTableView()
            
            UserDefaults.standard.setValue(true, forKey: "isTableViewActive")
        }
    }
    
    func configureTableView() {
        tableView.frame = view.bounds
        
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        
        tableView.rowHeight = 50
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureCollectionView() {
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
        
        view.addSubview(collectionView)
        setCollectionViewDelegates()
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
    }
    
    func setCollectionViewDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    /// Fetches JSON data from Google Sheet API
    func fetchData() {
        DispatchQueue.global(qos: .userInitiated).async {
            let url = URL(string: "https://sheets.googleapis.com/v4/spreadsheets/1wDg1ZvDxA7nFzUJcl8B9Q5JiyIyny_44xwiOqNhYxZw/values/PDFexpert!A2:D38?key=AIzaSyDSE21FBc2H_Z-O8kqsHPAYhmGOCypi2wg")!
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    print(error?.localizedDescription ?? "Unknown error")
                    return
                }
                
                let decoder = JSONDecoder()
                
                if let jsonResponse = try? decoder.decode(JSONResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.treeFromJsonResponse(response: jsonResponse.values)
                    }
                } else {
                    print("Unable to parse JSON data")
                }
            }.resume()
        }
    }
    
    /// Initializes the tree from JSON response
    /// - Parameter response: JSON response array
    private func treeFromJsonResponse(response: [[String]]) {
        var response = response
        
        whileThereAreResponses: while !response.isEmpty {
            for element in response {
                let childEntry = Entry(id: element[0], parentID: element[1], itemType: element[2], itemName: element[3])
                let childNode = EntryNode(value: childEntry)
                
                if let parentID = childEntry.parentID {
                    if let parent = entryNode.findParent(withID: parentID) {
                        parent.addChild(childNode)
                        response.removeFirst()
                    } else {
                        if response.count > 1 {
                            response.append(response.removeFirst())
                        } else {
                            break whileThereAreResponses
                        }
                    }
                } else {
                    entryNode.addChild(childNode)
                    response.removeFirst()
                }
            }
        }
        tableView.reloadData()
    }
}
