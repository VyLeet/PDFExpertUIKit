//
//  EntryListVC.swift
//  PDFExpertUIKit
//
//  Created by Nazariy Vysokinskyi on 02.07.2021.
//

import UIKit
import GTMSessionFetcher

enum LayoutType: String {
    case table = "square.grid.2x2.fill"
    case collection = "list.bullet"
}

class EntryListVC: UIViewController {
    
    var layoutType: LayoutType
    
    lazy var tableView = UITableView()
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    
    var entryNode = EntryNode(value: Entry(id: "", parentID: "", itemType: "d", itemName: "Main Folder")) {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - INITIALIZERS
    init(entryNode: EntryNode, layoutType: LayoutType) {
        self.layoutType = layoutType
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
            let dataFetcher = DataFetcher()
            entryNode = dataFetcher.getFileTree()
            
            dataFetcher.readSheet()
        }
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 100)
        
        setTableViewDelegates()
        setCollectionViewDelegates()
        
        if layoutType == .table {
            configureTableView()
        } else {
            configureCollectionView()
        }
        
        configureNavBarItems()
        
        
        title = entryNode.value.itemName
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
