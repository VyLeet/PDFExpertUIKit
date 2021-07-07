//
//  EntryListVC.swift
//  PDFExpertUIKit
//
//  Created by Nazariy Vysokinskyi on 02.07.2021.
//

import UIKit

class EntryListVC: UIViewController {
    
    var tableView = UITableView()
    var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
    
    var tableViewIsActive: Bool {
        tableView.superview == view
    }
    
    var entryNode = EntryNode(value: Entry(id: "", parentID: "", itemType: "d", itemName: "Main Folder"))
    
    // MARK: - INITIALIZERS
    init(entryNode: EntryNode) {
        self.entryNode = entryNode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEWDIDLOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if entryNode.value.itemName == "Main Folder" {
            print("Fetching data")
            fetchData()
        }
        
        configureTableView()
//        configureCollectionView()
        configureNavBarItems()
        
        view.backgroundColor = .white
        title = entryNode.value.itemName
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
