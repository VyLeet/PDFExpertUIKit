//
//  DummyCollectionViewCell.swift
//  PDFExpertUIKit
//
//  Created by Nazariy Vysokinskyi on 07.07.2021.
//

import UIKit

class DummyCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
