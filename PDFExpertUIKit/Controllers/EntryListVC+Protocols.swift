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
        let newEntryListVC = EntryListVC(entryNode: entryNode.children[indexPath.row])
        self.navigationController?.pushViewController(newEntryListVC, animated: true)
        tableView.reloadData()
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
        let newEntryListVC = EntryListVC(entryNode: entryNode.children[indexPath.row])
        self.navigationController?.pushViewController(newEntryListVC, animated: true)
        collectionView.reloadData()
    }
}
