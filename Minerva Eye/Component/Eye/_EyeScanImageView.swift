//
//  ScanImageView.swift
//  DocScan
//
//  Created by RaulF on 03/03/2020.
//  Copyright © 2020 ImTech. All rights reserved.
//

import UIKit

class EyeScanImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 7.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.red.cgColor
        backgroundColor = UIColor.init(white: 1.0, alpha: 0.1)
        clipsToBounds = true
    }
}
