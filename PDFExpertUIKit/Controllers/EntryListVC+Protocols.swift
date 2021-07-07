//
//  EntryListVC+.swift
//  PDFExpertUIKit
//
//  Created by Nazariy Vysokinskyi on 06.07.2021.
//

import UIKit

// MARK: - EXTENSIONS

extension EntryListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        entryNode.children.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as! TableViewCell
        let entry = entryNode.children[indexPath.row].value
        cell.set(with: entry)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if entryNode.children[indexPath.row].value.itemType == "d" {
//            print(entryNode.value.itemType)
            let newEntryListVC = EntryListVC(entryNode: entryNode.children[indexPath.row], layoutType: self.layoutType)
            self.navigationController?.pushViewController(newEntryListVC, animated: true)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        entryNode.children[indexPath.row].value.itemType == "d"
    }
}

extension EntryListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        entryNode.children.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        let entry = entryNode.children[indexPath.row].value
        cell.set(with: entry)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if entryNode.children[indexPath.row].value.itemType == "d" {
            let newEntryListVC = EntryListVC(entryNode: entryNode.children[indexPath.row], layoutType: self.layoutType)
            self.navigationController?.pushViewController(newEntryListVC, animated: true)
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        entryNode.children[indexPath.row].value.itemType == "d"
    }
    
}
