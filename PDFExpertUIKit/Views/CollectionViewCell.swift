//
//  CollectionViewCell.swift
//  PDFExpertUIKit
//
//  Created by Nazariy Vysokinskyi on 07.07.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    var entryImageView = UIImageView()
    var entryTitleLabel = UILabel()
    
    static let identifier = "CollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(entryImageView)
        contentView.addSubview(entryTitleLabel)
        
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
        entryImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        entryImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setTitleLabelConstraints() {
        entryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        entryTitleLabel.centerYAnchor.constraint(equalTo: entryImageView.bottomAnchor, constant: 20).isActive = true
        entryTitleLabel.leadingAnchor.constraint(equalTo: entryImageView.leadingAnchor).isActive = true
        entryTitleLabel.trailingAnchor.constraint(equalTo: entryImageView.trailingAnchor).isActive = true
        entryTitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
