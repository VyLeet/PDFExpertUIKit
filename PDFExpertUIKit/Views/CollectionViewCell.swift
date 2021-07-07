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
        
//        setImageConstraints()
//        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with entry: Entry) {
        entryImageView.image = UIImage(systemName: entry.itemType == "d" ? "folder.fill" : "doc.richtext.fill")
        entryTitleLabel.text = entry.itemName
        
    }
    
    func configureImageView() {
        entryImageView.contentMode = .scaleAspectFit
    }
    
    func configureTitleLabel() {
        entryTitleLabel.numberOfLines = 0
        entryTitleLabel.adjustsFontSizeToFitWidth = true
        
        entryTitleLabel.textAlignment = .center
    }
    
//    func setImageConstraints() {
//        entryImageView.translatesAutoresizingMaskIntoConstraints = false
//        entryImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        entryImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
//        entryImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        entryImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
//    }
//
//    func setTitleLabelConstraints() {
//        entryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
//        entryTitleLabel.centerYAnchor.constraint(equalTo: entryImageView.bottomAnchor, constant: 20).isActive = true
//        entryTitleLabel.leadingAnchor.constraint(equalTo: entryImageView.leadingAnchor).isActive = true
//        entryTitleLabel.trailingAnchor.constraint(equalTo: entryImageView.trailingAnchor).isActive = true
//        entryTitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        entryTitleLabel.frame = CGRect(x: 5,
                                       y: contentView.frame.size.height - 50,
                                       width: contentView.frame.size.width - 10,
                                       height: 50)
        entryImageView.frame = CGRect(x: 5,
                                       y: 0,
                                       width: contentView.frame.size.width - 10,
                                       height: contentView.frame.size.height - 50)
    }
}
