//
//  TableViewCell.swift
//  PDFExpertUIKit
//
//  Created by Nazariy Vysokinskyi on 06.07.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var entryImageView = UIImageView()
    var entryTitleLabel = UILabel()
    
    static let identifier = "TableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(entryImageView)
        addSubview(entryTitleLabel)
        
        configureImageView()
        configureTitleLabel()
        
        setImageConstraints()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with entry: Entry) {
        entryImageView.image = UIImage(systemName: entry.itemType == "d" ? "folder.fill" : "doc.richtext.fill")
        entryTitleLabel.text = entry.itemName
    }
    
    func setDummyData() {
        entryImageView.image = UIImage(systemName: "folder.fill")
        entryTitleLabel.text = "Some Folder"
    }
    
    func configureImageView() {
        
    }
    
    func configureTitleLabel() {
        entryTitleLabel.numberOfLines = 0
        entryTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setImageConstraints() {
        entryImageView.translatesAutoresizingMaskIntoConstraints = false
        entryImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        entryImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        entryImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        entryImageView.widthAnchor.constraint(equalTo: entryImageView.heightAnchor).isActive = true
    }
    
    func setTitleLabelConstraints() {
        entryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        entryTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        entryTitleLabel.leadingAnchor.constraint(equalTo: entryImageView.trailingAnchor, constant: 20).isActive = true
        entryTitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        entryTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
