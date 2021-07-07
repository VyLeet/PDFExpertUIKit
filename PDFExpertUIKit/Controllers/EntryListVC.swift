//
//  EntryListVC.swift
//  PDFExpertUIKit
//
//  Created by Nazariy Vysokinskyi on 02.07.2021.
//

import UIKit

class EntryListVC: UIViewController {
    
    enum LayoutType: String {
        case table = "square.grid.2x2.fill"
        case collection = "list.bullet"
    }
    
    var layoutType: LayoutType
    
    var tableView = UITableView()
    var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
    
    var entryNode = EntryNode(value: Entry(id: "", parentID: "", itemType: "d", itemName: "Main Folder"))
    
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
            print("Fetching data")
            fetchData()
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width / 3.5, height: view.frame.size.width / 3.5)
        collectionView.collectionViewLayout = layout
        
        if layoutType == .table {
            configureTableView()
        } else {
            configureCollectionView()
        }
        
        configureNavBarItems()
        
        
//        view.backgroundColor = .white
        title = entryNode.value.itemName
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
